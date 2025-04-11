package org.robotlegs.base {
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import flash.utils.getQualifiedClassName;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.core.IViewMap;

  public class ViewMap extends ViewMapBase implements IViewMap {
    protected var mappedPackages:Array;
    protected var mappedTypes:Dictionary;
    protected var injectedViews:Dictionary;

    public function ViewMap(contextView:DisplayObjectContainer, injector:IInjector) {
      super(contextView,injector);
      this.mappedPackages = new Array();
      this.mappedTypes = new Dictionary(false);
      this.injectedViews = new Dictionary(true);
    }

    public function mapPackage(packageName:String) : void {
      if(this.mappedPackages.indexOf(packageName) == -1) {
        this.mappedPackages.push(packageName);
        ++viewListenerCount;
        if(viewListenerCount == 1) {
          this.addListeners();
        }
      }
    }

    public function unmapPackage(packageName:String) : void {
      var index:int = int(this.mappedPackages.indexOf(packageName));
      if(index > -1) {
        this.mappedPackages.splice(index,1);
        --viewListenerCount;
        if(viewListenerCount == 0) {
          this.removeListeners();
        }
      }
    }

    public function mapType(type:Class) : void {
      if(Boolean(this.mappedTypes[type])) {
        return;
      }
      this.mappedTypes[type] = type;
      ++viewListenerCount;
      if(viewListenerCount == 1) {
        this.addListeners();
      }
      if(Boolean(contextView) && contextView is type) {
        this.injectInto(contextView);
      }
    }

    public function unmapType(type:Class) : void {
      var mapping:Class = this.mappedTypes[type];
      delete this.mappedTypes[type];
      if(Boolean(mapping)) {
        --viewListenerCount;
        if(viewListenerCount == 0) {
          this.removeListeners();
        }
      }
    }

    public function hasType(type:Class) : Boolean {
      return this.mappedTypes[type] != null;
    }

    public function hasPackage(packageName:String) : Boolean {
      return this.mappedPackages.indexOf(packageName) > -1;
    }

    override protected function addListeners() : void {
      if(Boolean(contextView) && enabled) {
        contextView.addEventListener(Event.ADDED_TO_STAGE,this.onViewAdded,useCapture,0,true);
      }
    }

    override protected function removeListeners() : void {
      if(Boolean(contextView)) {
        contextView.removeEventListener(Event.ADDED_TO_STAGE,this.onViewAdded,useCapture);
      }
    }

    override protected function onViewAdded(e:Event) : void {
      var type:Class = null;
      var len:int = 0;
      var className:String = null;
      var i:int = 0;
      var packageName:String = null;
      var target:DisplayObject = DisplayObject(e.target);
      if(Boolean(this.injectedViews[target])) {
        return;
      }
      for each(type in this.mappedTypes) {
        if(target is type) {
          this.injectInto(target);
          return;
        }
      }
      len = int(this.mappedPackages.length);
      if(len > 0) {
        className = getQualifiedClassName(target);
        for(i = 0; i < len; i++) {
          packageName = this.mappedPackages[i];
          if(className.indexOf(packageName) == 0) {
            this.injectInto(target);
            return;
          }
        }
      }
    }

    protected function injectInto(target:DisplayObject) : void {
      injector.injectInto(target);
      this.injectedViews[target] = true;
    }
  }
}
