package org.swiftsuspenders.injectionresults {
  import org.swiftsuspenders.Injector;

  public class InjectClassResult extends InjectionResult {
    private var m_responseType:Class;

    public function InjectClassResult(responseType:Class) {
      super();
      this.m_responseType = responseType;
    }

    override public function getResponse(injector:Injector) : Object {
      return injector.instantiate(this.m_responseType);
    }
  }
}
