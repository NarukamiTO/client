package org.robotlegs.base {
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import flash.utils.getQualifiedClassName;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.core.IMediator;
  import org.robotlegs.core.IMediatorMap;
  import org.robotlegs.core.IReflector;

  public class MediatorMap extends ViewMapBase implements IMediatorMap {
    protected static const enterFrameDispatcher:Sprite = new Sprite();

    protected var mediatorByView:Dictionary;
    protected var mappingConfigByView:Dictionary;
    protected var mappingConfigByViewClassName:Dictionary;
    protected var mediatorsMarkedForRemoval:Dictionary;
    protected var hasMediatorsMarkedForRemoval:Boolean;
    protected var reflector:IReflector;

    public function MediatorMap(contextView:DisplayObjectContainer, injector:IInjector, reflector:IReflector) {
      super(contextView,injector);
      this.reflector = reflector;
      this.mediatorByView = new Dictionary(true);
      this.mappingConfigByView = new Dictionary(true);
      this.mappingConfigByViewClassName = new Dictionary(false);
      this.mediatorsMarkedForRemoval = new Dictionary(false);
    }

    public function mapView(viewClassOrName:*, mediatorClass:Class, injectViewAs:* = null, autoCreate:Boolean = true, autoRemove:Boolean = true) : void {
      var viewClassName:String = this.reflector.getFQCN(viewClassOrName);
      if(this.mappingConfigByViewClassName[viewClassName] != null) {
        throw new ContextError(ContextError.E_MEDIATORMAP_OVR + " - " + mediatorClass);
      }
      if(this.reflector.classExtendsOrImplements(mediatorClass,IMediator) == false) {
        throw new ContextError(ContextError.E_MEDIATORMAP_NOIMPL + " - " + mediatorClass);
      }
      var config:MappingConfig = new MappingConfig();
      config.mediatorClass = mediatorClass;
      config.autoCreate = autoCreate;
      config.autoRemove = autoRemove;
      if(injectViewAs) {
        if(injectViewAs is Array) {
          config.typedViewClasses = (injectViewAs as Array).concat();
        } else if(injectViewAs is Class) {
          config.typedViewClasses = [injectViewAs];
        }
      } else if(viewClassOrName is Class) {
        config.typedViewClasses = [viewClassOrName];
      }
      this.mappingConfigByViewClassName[viewClassName] = config;
      if(autoCreate || autoRemove) {
        ++viewListenerCount;
        if(viewListenerCount == 1) {
          this.addListeners();
        }
      }
      if(autoCreate && contextView && viewClassName == getQualifiedClassName(contextView)) {
        this.createMediatorUsing(contextView,viewClassName,config);
      }
    }

    public function unmapView(viewClassOrName:*) : void {
      var viewClassName:String = this.reflector.getFQCN(viewClassOrName);
      var config:MappingConfig = this.mappingConfigByViewClassName[viewClassName];
      if(Boolean(config) && (config.autoCreate || config.autoRemove)) {
        --viewListenerCount;
        if(viewListenerCount == 0) {
          this.removeListeners();
        }
      }
      delete this.mappingConfigByViewClassName[viewClassName];
    }

    public function createMediator(viewComponent:Object) : IMediator {
      return this.createMediatorUsing(viewComponent);
    }

    public function registerMediator(viewComponent:Object, mediator:IMediator) : void {
      var mediatorClass:Class = this.reflector.getClass(mediator);
      injector.hasMapping(mediatorClass) && injector.unmap(mediatorClass);
      injector.mapValue(mediatorClass,mediator);
      this.mediatorByView[viewComponent] = mediator;
      this.mappingConfigByView[viewComponent] = this.mappingConfigByViewClassName[getQualifiedClassName(viewComponent)];
      mediator.setViewComponent(viewComponent);
      mediator.preRegister();
    }

    public function removeMediator(mediator:IMediator) : IMediator {
      var viewComponent:Object = null;
      var mediatorClass:Class = null;
      if(Boolean(mediator)) {
        viewComponent = mediator.getViewComponent();
        mediatorClass = this.reflector.getClass(mediator);
        delete this.mediatorByView[viewComponent];
        delete this.mappingConfigByView[viewComponent];
        mediator.preRemove();
        mediator.setViewComponent(null);
        injector.hasMapping(mediatorClass) && injector.unmap(mediatorClass);
      }
      return mediator;
    }

    public function removeMediatorByView(viewComponent:Object) : IMediator {
      return this.removeMediator(this.retrieveMediator(viewComponent));
    }

    public function retrieveMediator(viewComponent:Object) : IMediator {
      return this.mediatorByView[viewComponent];
    }

    public function hasMapping(viewClassOrName:*) : Boolean {
      var viewClassName:String = this.reflector.getFQCN(viewClassOrName);
      return this.mappingConfigByViewClassName[viewClassName] != null;
    }

    public function hasMediatorForView(viewComponent:Object) : Boolean {
      return this.mediatorByView[viewComponent] != null;
    }

    public function hasMediator(mediator:IMediator) : Boolean {
      var med:IMediator = null;
      for each(med in this.mediatorByView) {
        if(med == mediator) {
          return true;
        }
      }
      return false;
    }

    override protected function addListeners() : void {
      if(Boolean(contextView) && enabled) {
        contextView.addEventListener(Event.ADDED_TO_STAGE,this.onViewAdded,useCapture,0,true);
        contextView.addEventListener(Event.REMOVED_FROM_STAGE,this.onViewRemoved,useCapture,0,true);
      }
    }

    override protected function removeListeners() : void {
      if(Boolean(contextView)) {
        contextView.removeEventListener(Event.ADDED_TO_STAGE,this.onViewAdded,useCapture);
        contextView.removeEventListener(Event.REMOVED_FROM_STAGE,this.onViewRemoved,useCapture);
      }
    }

    override protected function onViewAdded(e:Event) : void {
      if(Boolean(this.mediatorsMarkedForRemoval[e.target])) {
        delete this.mediatorsMarkedForRemoval[e.target];
        return;
      }
      var viewClassName:String = getQualifiedClassName(e.target);
      var config:MappingConfig = this.mappingConfigByViewClassName[viewClassName];
      if(Boolean(config) && config.autoCreate) {
        this.createMediatorUsing(e.target,viewClassName,config);
      }
    }

    protected function createMediatorUsing(viewComponent:Object, viewClassName:String = "", config:MappingConfig = null) : IMediator {
      var claxx:Class = null;
      var clazz:Class = null;
      var mediator:IMediator = this.mediatorByView[viewComponent];
      if(mediator == null) {
        viewClassName ||= getQualifiedClassName(viewComponent);
        config ||= this.mappingConfigByViewClassName[viewClassName];
        if(Boolean(config)) {
          for each(claxx in config.typedViewClasses) {
            injector.mapValue(claxx,viewComponent);
          }
          mediator = injector.instantiate(config.mediatorClass);
          for each(clazz in config.typedViewClasses) {
            injector.unmap(clazz);
          }
          this.registerMediator(viewComponent,mediator);
        }
      }
      return mediator;
    }

    protected function onViewRemoved(e:Event) : void {
      var config:MappingConfig = this.mappingConfigByView[e.target];
      if(Boolean(config) && config.autoRemove) {
        this.mediatorsMarkedForRemoval[e.target] = e.target;
        if(!this.hasMediatorsMarkedForRemoval) {
          this.hasMediatorsMarkedForRemoval = true;
          enterFrameDispatcher.addEventListener(Event.ENTER_FRAME,this.removeMediatorLater);
        }
      }
    }

    protected function removeMediatorLater(event:Event) : void {
      var view:DisplayObject = null;
      enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME,this.removeMediatorLater);
      for each(view in this.mediatorsMarkedForRemoval) {
        if(!view.stage) {
          this.removeMediatorByView(view);
        }
        delete this.mediatorsMarkedForRemoval[view];
      }
      this.hasMediatorsMarkedForRemoval = false;
    }
  }
}

class MappingConfig {
  public var mediatorClass:Class;
  public var typedViewClasses:Array;
  public var autoCreate:Boolean;
  public var autoRemove:Boolean;

  public function MappingConfig() {
    super();
  }
}
