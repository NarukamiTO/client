package org.swiftsuspenders {
  import flash.utils.getQualifiedClassName;
  import org.swiftsuspenders.injectionresults.InjectionResult;

  public class InjectionConfig {
    public var request:Class;
    public var injectionName:String;

    private var m_injector:Injector;
    private var m_result:InjectionResult;

    public function InjectionConfig(request:Class, injectionName:String) {
      super();
      this.request = request;
      this.injectionName = injectionName;
    }

    public function getResponse(injector:Injector) : Object {
      if(Boolean(this.m_result)) {
        return this.m_result.getResponse(this.m_injector || injector);
      }
      var parentConfig:InjectionConfig = (this.m_injector || injector).getAncestorMapping(this.request,this.injectionName);
      if(Boolean(parentConfig)) {
        return parentConfig.getResponse(injector);
      }
      return null;
    }

    public function hasResponse(injector:Injector) : Boolean {
      if(Boolean(this.m_result)) {
        return true;
      }
      var parentConfig:InjectionConfig = (this.m_injector || injector).getAncestorMapping(this.request,this.injectionName);
      return parentConfig != null;
    }

    public function hasOwnResponse() : Boolean {
      return this.m_result != null;
    }

    public function setResult(result:InjectionResult) : void {
      if(this.m_result != null && result != null) {
        trace("Warning: Injector already has a rule for type \"" + getQualifiedClassName(this.request) + "\", named \"" + this.injectionName + "\".\n " + "If you have overwritten this mapping intentionally you can use " + "\"injector.unmap()\" prior to your replacement mapping in order to " + "avoid seeing this message.");
      }
      this.m_result = result;
    }

    public function setInjector(injector:Injector) : void {
      this.m_injector = injector;
    }
  }
}
