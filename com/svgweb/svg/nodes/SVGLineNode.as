/*
Copyright (c) 2008 James Hight
Copyright (c) 2008 Richard R. Masters, for his changes.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

package com.svgweb.svg.nodes
{
	import com.svgweb.svg.core.SVGNode;
	import com.svgweb.svg.utils.SVGUnits;
	
    public class SVGLineNode extends SVGNode
    {        
        public function SVGLineNode(svgRoot:SVGSVGNode, xml:XML = null, isClone:Boolean = false):void {
            super(svgRoot, xml);
        }    
        
        /**
         * Generate graphics commands to draw a line
         **/
        protected override function generateGraphicsCommands():void {
            
            this._graphicsCommands = new  Array();
            
            var x1:Number = SVGUnits.cleanNumber(this.getAttribute('x1',0));
            var y1:Number = SVGUnits.cleanNumber(this.getAttribute('y1',0));
            var x2:Number = SVGUnits.cleanNumber(this.getAttribute('x2',0));
            var y2:Number = SVGUnits.cleanNumber(this.getAttribute('y2',0));
            
            //Width/height calculations for gradients
            this.setXMinMax(x1);
            this.setYMinMax(x2);
            
            this.setXMinMax(y1);
            this.setYMinMax(y2);
            
            this._graphicsCommands.push(['LINE', x1, y1, x2, y2]);
        }        
        
    }
}
