package org.swiftsuspenders {
  import flash.system.ApplicationDomain;
  import flash.utils.Dictionary;
  import flash.utils.describeType;
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;
  import org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint;
  import org.swiftsuspenders.injectionpoints.InjectionPoint;
  import org.swiftsuspenders.injectionpoints.MethodInjectionPoint;
  import org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint;
  import org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint;
  import org.swiftsuspenders.injectionpoints.PropertyInjectionPoint;
  import org.swiftsuspenders.injectionresults.InjectClassResult;
  import org.swiftsuspenders.injectionresults.InjectOtherRuleResult;
  import org.swiftsuspenders.injectionresults.InjectSingletonResult;
  import org.swiftsuspenders.injectionresults.InjectValueResult;

  public class Injector {
    private static var INJECTION_POINTS_CACHE:Dictionary = new Dictionary(true);

    private var m_parentInjector:Injector;
    private var m_applicationDomain:ApplicationDomain;
    private var m_mappings:Dictionary;
    private var m_injecteeDescriptions:Dictionary;
    private var m_attendedToInjectees:Dictionary;
    private var m_xmlMetadata:XML;

    public function Injector(xmlConfig:XML = null) {
      super();
      this.m_mappings = new Dictionary();
      if(xmlConfig != null) {
        this.m_injecteeDescriptions = new Dictionary(true);
      } else {
        this.m_injecteeDescriptions = INJECTION_POINTS_CACHE;
      }
      this.m_attendedToInjectees = new Dictionary(true);
      this.m_xmlMetadata = xmlConfig;
    }

    public static function purgeInjectionPointsCache() : void {
      INJECTION_POINTS_CACHE = new Dictionary(true);
    }

    public function mapValue(whenAskedFor:Class, useValue:Object, named:String = "") : * {
      var config:InjectionConfig = this.getMapping(whenAskedFor,named);
      config.setResult(new InjectValueResult(useValue));
      return config;
    }

    public function mapClass(whenAskedFor:Class, instantiateClass:Class, named:String = "") : * {
      var config:InjectionConfig = this.getMapping(whenAskedFor,named);
      config.setResult(new InjectClassResult(instantiateClass));
      return config;
    }

    public function mapSingleton(whenAskedFor:Class, named:String = "") : * {
      return this.mapSingletonOf(whenAskedFor,whenAskedFor,named);
    }

    public function mapSingletonOf(whenAskedFor:Class, useSingletonOf:Class, named:String = "") : * {
      var config:InjectionConfig = this.getMapping(whenAskedFor,named);
      config.setResult(new InjectSingletonResult(useSingletonOf));
      return config;
    }

    public function mapRule(whenAskedFor:Class, useRule:*, named:String = "") : * {
      var config:InjectionConfig = this.getMapping(whenAskedFor,named);
      config.setResult(new InjectOtherRuleResult(useRule));
      return useRule;
    }

    public function getMapping(whenAskedFor:Class, named:String = "") : InjectionConfig {
      var requestName:String = getQualifiedClassName(whenAskedFor);
      var config:InjectionConfig = this.m_mappings[requestName + "#" + named];
      if(!config) {
        config = this.m_mappings[requestName + "#" + named] = new InjectionConfig(whenAskedFor,named);
      }
      return config;
    }

    public function injectInto(target:Object) : void {
      var injectionPoint:InjectionPoint = null;
      if(Boolean(this.m_attendedToInjectees[target])) {
        return;
      }
      this.m_attendedToInjectees[target] = true;
      var targetClass:Class = getConstructor(target);
      var injecteeDescription:InjecteeDescription = this.m_injecteeDescriptions[targetClass] || this.getInjectionPoints(targetClass);
      var injectionPoints:Array = injecteeDescription.injectionPoints;
      var length:int = int(injectionPoints.length);
      for(var i:int = 0; i < length; i++) {
        injectionPoint = injectionPoints[i];
        injectionPoint.applyInjection(target,this);
      }
    }

    public function instantiate(clazz:Class) : * {
      var injecteeDescription:InjecteeDescription = this.m_injecteeDescriptions[clazz];
      if(!injecteeDescription) {
        injecteeDescription = this.getInjectionPoints(clazz);
      }
      var injectionPoint:InjectionPoint = injecteeDescription.ctor;
      var instance:* = injectionPoint.applyInjection(clazz,this);
      this.injectInto(instance);
      return instance;
    }

    public function unmap(clazz:Class, named:String = "") : void {
      var mapping:InjectionConfig = this.getConfigurationForRequest(clazz,named);
      if(!mapping) {
        throw new InjectorError("Error while removing an injector mapping: " + "No mapping defined for class " + getQualifiedClassName(clazz) + ", named \"" + named + "\"");
      }
      mapping.setResult(null);
    }

    public function hasMapping(clazz:Class, named:String = "") : Boolean {
      var mapping:InjectionConfig = this.getConfigurationForRequest(clazz,named);
      if(!mapping) {
        return false;
      }
      return mapping.hasResponse(this);
    }

    public function getInstance(clazz:Class, named:String = "") : * {
      var mapping:InjectionConfig = this.getConfigurationForRequest(clazz,named);
      if(!mapping || !mapping.hasResponse(this)) {
        throw new InjectorError("Error while getting mapping response: " + "No mapping defined for class " + getQualifiedClassName(clazz) + ", named \"" + named + "\"");
      }
      return mapping.getResponse(this);
    }

    public function createChildInjector(applicationDomain:ApplicationDomain = null) : Injector {
      var injector:Injector = new Injector();
      injector.setApplicationDomain(applicationDomain);
      injector.setParentInjector(this);
      return injector;
    }

    public function setApplicationDomain(applicationDomain:ApplicationDomain) : void {
      this.m_applicationDomain = applicationDomain;
    }

    public function getApplicationDomain() : ApplicationDomain {
      return Boolean(this.m_applicationDomain) ? this.m_applicationDomain : ApplicationDomain.currentDomain;
    }

    public function setParentInjector(parentInjector:Injector) : void {
      if(Boolean(this.m_parentInjector) && !parentInjector) {
        this.m_attendedToInjectees = new Dictionary(true);
      }
      this.m_parentInjector = parentInjector;
      if(Boolean(parentInjector)) {
        this.m_attendedToInjectees = parentInjector.attendedToInjectees;
      }
    }

    public function getParentInjector() : Injector {
      return this.m_parentInjector;
    }

    internal function getAncestorMapping(whenAskedFor:Class, named:String = null) : InjectionConfig {
      var parentConfig:InjectionConfig = null;
      var parent:Injector = this.m_parentInjector;
      while(Boolean(parent)) {
        parentConfig = parent.getConfigurationForRequest(whenAskedFor,named,false);
        if(Boolean(parentConfig) && parentConfig.hasOwnResponse()) {
          return parentConfig;
        }
        parent = parent.getParentInjector();
      }
      return null;
    }

    internal function get attendedToInjectees() : Dictionary {
      return this.m_attendedToInjectees;
    }

    private function getInjectionPoints(clazz:Class) : InjecteeDescription {
      var injectionPoints:Array;
      var injecteeDescription:InjecteeDescription;
      var node:XML = null;
      var ctorInjectionPoint:InjectionPoint = null;
      var injectionPoint:InjectionPoint = null;
      var postConstructMethodPoints:Array = null;
      var description:XML = describeType(clazz);
      if(description.@name != "Object" && description.factory.extendsClass.length() == 0) {
        throw new InjectorError("Interfaces can\'t be used as instantiatable classes.");
      }
      injectionPoints = [];
      if(Boolean(this.m_xmlMetadata)) {
        this.createInjectionPointsFromConfigXML(description);
        this.addParentInjectionPoints(description,injectionPoints);
      }
      node = description.factory.constructor[0];
      if(Boolean(node)) {
        ctorInjectionPoint = new ConstructorInjectionPoint(node,clazz,this);
      } else {
        ctorInjectionPoint = new NoParamsConstructorInjectionPoint();
      }
      for each(node in description.factory.*.(name() == "variable" || name() == "accessor").metadata.(@name == "Inject")) {
        injectionPoint = new PropertyInjectionPoint(node);
        injectionPoints.push(injectionPoint);
      }
      for each(node in description.factory.method.metadata.(@name == "Inject")) {
        injectionPoint = new MethodInjectionPoint(node,this);
        injectionPoints.push(injectionPoint);
      }
      postConstructMethodPoints = [];
      for each(node in description.factory.method.metadata.(@name == "PostConstruct")) {
        injectionPoint = new PostConstructInjectionPoint(node,this);
        postConstructMethodPoints.push(injectionPoint);
      }
      if(postConstructMethodPoints.length > 0) {
        postConstructMethodPoints.sortOn("order",Array.NUMERIC);
        injectionPoints.push.apply(injectionPoints,postConstructMethodPoints);
      }
      injecteeDescription = new InjecteeDescription(ctorInjectionPoint,injectionPoints);
      this.m_injecteeDescriptions[clazz] = injecteeDescription;
      return injecteeDescription;
    }

    private function getConfigurationForRequest(clazz:Class, named:String, traverseAncestors:Boolean = true) : InjectionConfig {
      var requestName:String = getQualifiedClassName(clazz);
      var config:InjectionConfig = this.m_mappings[requestName + "#" + named];
      if(!config && traverseAncestors && this.m_parentInjector && this.m_parentInjector.hasMapping(clazz,named)) {
        config = this.getAncestorMapping(clazz,named);
      }
      return config;
    }

    private function createInjectionPointsFromConfigXML(description:XML) : void {
      var node:XML = null;
      var className:String = null;
      var metaNode:XML = null;
      var typeNode:XML = null;
      var arg:XML = null;
      for each(node in description..metadata.(@name == "Inject" || @name == "PostConstruct")) {
        delete node.parent().metadata.(@name == "Inject" || @name == "PostConstruct")[0];
      }
      className = description.factory.@type;
      for each(node in this.m_xmlMetadata.type.(@name == className).children()) {
        metaNode = <metadata/>;
        if(node.name() == "postconstruct") {
          metaNode.@name = "PostConstruct";
          if(Boolean(node.@order.length())) {
            metaNode.appendChild(<arg key='order' value={node.@order}/>);
          }
        } else {
          metaNode.@name = "Inject";
          if(Boolean(node.@injectionname.length())) {
            metaNode.appendChild(<arg key='name' value={node.@injectionname}/>);
          }
          for each(arg in node.arg) {
            metaNode.appendChild(<arg key='name' value={arg.@injectionname}/>);
          }
        }
        if(node.name() == "constructor") {
          typeNode = description.factory[0];
        } else {
          typeNode = description.factory.*.(attribute("name") == node.@name)[0];
          if(!typeNode) {
            throw new InjectorError("Error in XML configuration: Class \"" + className + "\" doesn\'t contain the instance member \"" + node.@name + "\"");
          }
        }
        typeNode.appendChild(metaNode);
      }
    }

    private function addParentInjectionPoints(description:XML, injectionPoints:Array) : void {
      var parentClassName:String = description.factory.extendsClass.@type[0];
      if(!parentClassName) {
        return;
      }
      var parentClass:Class = Class(getDefinitionByName(parentClassName));
      var parentDescription:InjecteeDescription = this.m_injecteeDescriptions[parentClass] || this.getInjectionPoints(parentClass);
      var parentInjectionPoints:Array = parentDescription.injectionPoints;
      injectionPoints.push.apply(injectionPoints,parentInjectionPoints);
    }
  }
}

import org.swiftsuspenders.injectionpoints.InjectionPoint;
final class InjecteeDescription {
  public var ctor:InjectionPoint;
  public var injectionPoints:Array;

  public function InjecteeDescription(ctor:InjectionPoint, injectionPoints:Array) {
    super();
    this.ctor = ctor;
    this.injectionPoints = injectionPoints;
  }
}
