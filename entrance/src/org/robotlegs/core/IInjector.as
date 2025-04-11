package org.robotlegs.core {
  import flash.system.ApplicationDomain;

  public interface IInjector {
    function mapValue(whenAskedFor:Class, useValue:Object, named:String = "") : *;
    function mapClass(whenAskedFor:Class, instantiateClass:Class, named:String = "") : *;
    function mapSingleton(whenAskedFor:Class, named:String = "") : *;
    function mapSingletonOf(whenAskedFor:Class, useSingletonOf:Class, named:String = "") : *;
    function mapRule(whenAskedFor:Class, useRule:*, named:String = "") : *;
    function injectInto(target:Object) : void;
    function instantiate(clazz:Class) : *;
    function getInstance(clazz:Class, named:String = "") : *;
    function createChild(applicationDomain:ApplicationDomain = null) : IInjector;
    function unmap(clazz:Class, named:String = "") : void;
    function hasMapping(clazz:Class, named:String = "") : Boolean;
    function get applicationDomain() : ApplicationDomain;
    function set applicationDomain(value:ApplicationDomain) : void;
  }
}
