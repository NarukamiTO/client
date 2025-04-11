package org.robotlegs.core {
  import flash.display.DisplayObjectContainer;

  public interface IMediatorMap {
    function mapView(viewClassOrName:*, mediatorClass:Class, injectViewAs:* = null, autoCreate:Boolean = true, autoRemove:Boolean = true) : void;
    function unmapView(viewClassOrName:*) : void;
    function createMediator(viewComponent:Object) : IMediator;
    function registerMediator(viewComponent:Object, mediator:IMediator) : void;
    function removeMediator(mediator:IMediator) : IMediator;
    function removeMediatorByView(viewComponent:Object) : IMediator;
    function retrieveMediator(viewComponent:Object) : IMediator;
    function hasMapping(viewClassOrName:*) : Boolean;
    function hasMediator(mediator:IMediator) : Boolean;
    function hasMediatorForView(viewComponent:Object) : Boolean;
    function get contextView() : DisplayObjectContainer;
    function set contextView(value:DisplayObjectContainer) : void;
    function get enabled() : Boolean;
    function set enabled(value:Boolean) : void;
  }
}
