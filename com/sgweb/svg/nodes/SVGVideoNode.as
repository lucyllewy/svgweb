/*
 Copyright (c) 2009 by contributors:

 * James Hight (http://labs.zavoo.com/)
 * Richard R. Masters

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/

package com.sgweb.svg.nodes
{

    import com.sgweb.svg.core.SVGNode;
    import com.sgweb.svg.core.SVGTimedNode;
    import com.sgweb.svg.utils.SVGUnits;
    import flash.events.Event;
    import flash.events.NetStatusEvent;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.media.Video;

    public class SVGVideoNode extends SVGTimedNode {
        protected var video:Video;
        protected var netStream:NetStream;

        public function SVGVideoNode(svgRoot:SVGSVGNode, xml:XML, original:SVGNode = null):void {
            super(svgRoot, xml, original);
        }

        override protected function onAddedToStage(event:Event):void {
            super.onAddedToStage(event);

            var connection:NetConnection = new NetConnection();
            connection.connect(null);
       
            netStream = new NetStream(connection);
       
            var _width:Number = SVGUnits.cleanNumber(this.getAttribute('width', '0'));
            var _height:Number = SVGUnits.cleanNumber(this.getAttribute('height', '0'));
            video = new Video(_width, _height);
            this.viewBoxSprite.addChild(video);
       
            video.attachNetStream(netStream);
       
            netStream.addEventListener(NetStatusEvent.NET_STATUS, handleNetEvent);
            netStream.client = this;

        }

        protected function handleNetEvent(status:NetStatusEvent):void {
            //this.dbg("netstat: " + status.info.code);
        }

        protected function onMetaData(meta:Object):void {
            //this.dbg("meta: " + meta);
        }

        override protected function setAttributes():void {
            super.setAttributes();
            if (video) {
                video.width = SVGUnits.cleanNumber(this.getAttribute('width', '0'));
                video.height = SVGUnits.cleanNumber(this.getAttribute('height', '0'));
            }
        }

        override protected function repeatIntervalStarted():void {
            super.repeatIntervalStarted();

            // Get the video location
            var videoHref:String = this.getAttribute('href');
            if (!videoHref) {
                return;
            }

            // Prepend the xml:base
            var xmlBase:String = this.getAttribute('base');
            if (xmlBase && xmlBase != '') {
                videoHref = xmlBase + videoHref;
            }
            if (netStream) {
                netStream.play(videoHref);
            }
        }

        override protected function repeatIntervalEnded():void {
            super.repeatIntervalEnded();
            if (netStream) {
                netStream.pause();
            }
        }

    }
}
