#!/bin/bash
curl -s "http://127.0.0.1/_HB_?service=offline"
#如果java应用没有提供上下线接口，可以使用tengine的updown
curl -s -X DELETE "http://127.0.0.1/eW91emFuCg==/hc"
sleep 10s
