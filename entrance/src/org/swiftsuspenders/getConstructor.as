package org.swiftsuspenders {
  import flash.utils.Proxy;
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;

  function getConstructor(value:Object) : Class {
    var fqcn:String = null;
    if(value is Proxy || value is Number || value is XML || value is XMLList) {
      fqcn = getQualifiedClassName(value);
      return Class(getDefinitionByName(fqcn));
    }
    return value.constructor;
  }
}
