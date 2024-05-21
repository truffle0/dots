#!/bin/env python
from pulsectl import Pulse, PulseEventInfo, PulseLoopStop
import json
from statistics import fmean as mean
from time import sleep

def main():
	with Pulse('bar-volume-display') as pulse:
		### Template for output ###
		output = {
			"source": {
				"name": "",
				"mute": False,
				"volume": 0.0,
			},
			"sink": {
				"name": "",
				"mute": False,
				"volume": 0.0,
			}
		}

		### Routines to updated data when changed ###

		sink = None
		source = None 
		def poll_sink_vol() -> None:
			cur = pulse.get_sink_by_name(sink)
			output['sink']['mute'] = True if cur.mute == 1 else False
			output['sink']['volume'] = str(int(mean(cur.volume.values) * 100))

		def poll_source_vol() -> None:
			cur = pulse.get_source_by_name(source)
			output['source']['mute'] = True if cur.mute == 1 else False
			output['source']['volume'] = str(int(mean(cur.volume.values) * 100))

		def poll_defaults() -> None:
			nonlocal source
			nonlocal sink
			nonlocal output

			serv = pulse.server_info()
			source = serv.default_source_name
			sink = serv.default_sink_name

			output['source']['name'] = pulse.get_source_by_name(source).description
			output['sink']['name'] = pulse.get_sink_by_name(sink).description

			poll_source_vol()
			poll_sink_vol()

		poll_defaults()
		print(json.dumps(output), flush=True)
		
		### Start Monitoring ###
		event = None
		def event_notify(ev: PulseEventInfo):
			nonlocal event
			if ev.t == 'change' and ev.facility in ('server', 'source', 'sink'):
				event = ev.facility
				raise PulseLoopStop
			
	

		### Response Loop ###
		while True:
			pulse.event_mask_set('all')
			pulse.event_callback_set(event_notify)
			pulse.event_listen()

			match event:
				case 'server':
					poll_defaults()
				case 'sink':
					poll_sink_vol()
				case 'source':
					poll_source_vol()
			
			print(json.dumps(output), flush=True)
			sleep(0.1)

if __name__ == "__main__":
	main()