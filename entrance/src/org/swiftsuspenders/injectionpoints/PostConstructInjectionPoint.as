package org.swiftsuspenders.injectionpoints {
  import org.swiftsuspenders.Injector;

  public class PostConstructInjectionPoint extends InjectionPoint {
    protected var methodName:String;
    protected var orderValue:int;

    public function PostConstructInjectionPoint(node:XML, injector:Injector = null) {
      super(node,injector);
    }

    public function get order() : int {
      return this.orderValue;
    }

    override public function applyInjection(target:Object, injector:Injector) : Object {
      target[this.methodName]();
      return target;
    }

    override protected function initializeInjection(node:XML) : void {
      var orderArg:XMLList = null;
      var methodNode:XML = null;
      orderArg = node.arg.(@key == "order");
      methodNode = node.parent();
      this.orderValue = int(orderArg.@value);
      this.methodName = methodNode.@name.toString();
    }
  }
}
