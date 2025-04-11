package alternativa.osgi.service.display {
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.display.Stage;

  public class Display implements IDisplay {
    private var _stage:Stage;
    private var _mainContainer:DisplayObjectContainer;
    private var _backgroundLayer:DisplayObjectContainer;
    private var _contentLayer:DisplayObjectContainer;
    private var _contentUILayer:DisplayObjectContainer;
    private var _systemLayer:DisplayObjectContainer;
    private var _systemUILayer:DisplayObjectContainer;
    private var _dialogsLayer:DisplayObjectContainer;
    private var _loaderLayer:DisplayObjectContainer;
    private var _noticesLayer:DisplayObjectContainer;
    private var _cursorLayer:DisplayObjectContainer;

    public function Display(param1:DisplayObjectContainer) {
      super();
      this._stage = param1.stage;
      this._mainContainer = param1;
      this._backgroundLayer = this.addLayerSprite();
      this._contentLayer = this.addLayerSprite();
      this._contentUILayer = this.addLayerSprite();
      this._systemLayer = this.addLayerSprite();
      this._systemUILayer = this.addLayerSprite();
      this._dialogsLayer = this.addLayerSprite();
      this._loaderLayer = this.addLayerSprite();
      this._noticesLayer = this.addLayerSprite();
      this._cursorLayer = this.addLayerSprite();
    }

    private function addLayerSprite() : Sprite {
      var local1:Sprite = new Sprite();
      local1.mouseEnabled = false;
      local1.tabEnabled = false;
      this._mainContainer.addChild(local1);
      return local1;
    }

    public function get stage() : Stage {
      return this._stage;
    }

    public function get mainContainer() : DisplayObjectContainer {
      return this._mainContainer;
    }

    public function get backgroundLayer() : DisplayObjectContainer {
      return this._backgroundLayer;
    }

    public function get contentLayer() : DisplayObjectContainer {
      return this._contentLayer;
    }

    public function get contentUILayer() : DisplayObjectContainer {
      return this._contentUILayer;
    }

    public function get systemLayer() : DisplayObjectContainer {
      return this._systemLayer;
    }

    public function get systemUILayer() : DisplayObjectContainer {
      return this._systemUILayer;
    }

    public function get dialogsLayer() : DisplayObjectContainer {
      return this._dialogsLayer;
    }

    public function get loaderLayer() : DisplayObjectContainer {
      return this._loaderLayer;
    }

    public function get noticesLayer() : DisplayObjectContainer {
      return this._noticesLayer;
    }

    public function get cursorLayer() : DisplayObjectContainer {
      return this._cursorLayer;
    }
  }
}
