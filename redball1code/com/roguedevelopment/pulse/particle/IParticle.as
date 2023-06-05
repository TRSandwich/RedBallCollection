/**
 *  Latest information on this project can be found at http://www.rogue-development.com/pulseParticles.xml
 * 
 *  Copyright (c) 2008 Marc Hughes 
 * 
 *  Permission is hereby granted, free of charge, to any person obtaining a 
 *  copy of this software and associated documentation files (the "Software"), 
 *  to deal in the Software without restriction, including without limitation 
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 *  and/or sell copies of the Software, and to permit persons to whom the Software 
 *  is furnished to do so, subject to the following conditions:
 * 
 *  The above copyright notice and this permission notice shall be included in all 
 *  copies or substantial portions of the Software.
 * 
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 *  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 *  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 *  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 * 
 * -------------------------------------------------------------------------------------------
 * 
 **/

package com.roguedevelopment.pulse.particle
{
	public interface IParticle
	{		
		function get params() : Object;
		function get x() : Number;
		function get y() : Number;
		function set x(val:Number):void;
		function set y(val:Number):void;
		function get birthTime() : Number;
		function get scaleX() : Number;
		function set scaleX(val:Number) : void;
		function get scaleY() : Number;
		function set scaleY(val:Number) : void;
		function get rules():Array;
		function set rules(val:Array) : void;
		function get visible() :Boolean ;
		function set visible(val:Boolean) : void;
		function set alpha(val:Number) : void;
		function get alpha() : Number;
		function get rotation() : Number;
		function set rotation( val : Number ) : void;
		function remove() : void;
	}
}
