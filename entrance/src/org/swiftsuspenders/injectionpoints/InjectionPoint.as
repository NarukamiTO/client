package org.swiftsuspenders.injectionpoints {
  import org.swiftsuspenders.Injector;

  public class InjectionPoint {
    public function InjectionPoint(node:XML, injector:Injector) {
      super();
      this.initializeInjection(node);
    }

    public function applyInjection(target:Object, injector:Injector) : Object {
      return target;
    }

    protected function initializeInjection(node:XML) : void {
    }
  }
}
