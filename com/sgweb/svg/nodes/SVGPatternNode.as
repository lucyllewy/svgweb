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


package com.sgweb.svg.nodes {
    import com.sgweb.svg.core.SVGNode;
    import com.sgweb.svg.utils.SVGUnits;
    
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.geom.Matrix;    
    
    public class SVGPatternNode extends SVGNode {        
        
        public function SVGPatternNode(svgRoot:SVGSVGNode, xml:XML = null, original:SVGNode = null) {
            super(svgRoot, xml, original);
        }    
        
        override public function drawNode(event:Event = null):void {            
            this.removeEventListener(Event.ENTER_FRAME, drawNode);    
            this._invalidDisplay = false;
            
            //If mask is is not currently being used don't show it
            this.visible = false;           
            
            this.svgRoot.doneRendering();
        }    
        
        public function beginPatternFill(node:SVGNode):void {
        	var patternWidth:Number = this.width;
            var patternHeight:Number = this.height;
            
            var tmp:String = this.getAttribute('width');
            if (tmp) {
                patternWidth = SVGUnits.cleanNumber(tmp);
            } 
            
            tmp = this.getAttribute('height');
            if (tmp) {
                patternHeight = SVGUnits.cleanNumber(tmp);
            }             
                        
            var patternX:Number = SVGUnits.cleanNumber(this.getAttribute('x'));
            var patternY:Number = SVGUnits.cleanNumber(this.getAttribute('y'));
            
            var matrix:Matrix = this.transform.concatenatedMatrix;
            var nodeMatrix:Matrix = node.transform.concatenatedMatrix;
            nodeMatrix.invert();
            
            matrix.concat(nodeMatrix);  
            matrix.translate(patternX, patternY);
            
            if ((patternWidth > 0) && (patternHeight > 0)) {
               var bitmapData:BitmapData = new BitmapData(patternWidth, patternHeight);
               bitmapData.draw(this);
               node.graphics.beginBitmapFill(bitmapData, matrix);
            }
        }
        
    }
}