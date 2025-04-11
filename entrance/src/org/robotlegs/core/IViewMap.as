package org.robotlegs.core {
  import flash.display.DisplayObjectContainer;

  public interface IViewMap {
    function mapPackage(packageName:String) : void;
    function unmapPackage(packageName:String) : void;
    function hasPackage(packageName:String) : Boolean;
    function mapType(type:Class) : void;
    function unmapType(type:Class) : void;
    function hasType(type:Class) : Boolean;
    function get contextView() : DisplayObjectContainer;
    function set contextView(value:DisplayObjectContainer) : void;
    function get enabled() : Boolean;
    function set enabled(value:Boolean) : void;
  }
}
