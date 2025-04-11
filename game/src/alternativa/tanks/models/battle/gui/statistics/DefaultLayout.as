package alternativa.tanks.models.battle.gui.statistics {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.LayoutManager;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import flash.display.DisplayObject;
  import flash.events.Event;

  public class DefaultLayout implements LayoutManager {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    private var deferred:Vector.<Widget> = new Vector.<Widget>();
    private var widgets:Vector.<Widget> = new Vector.<Widget>();
    private var initialized:Boolean;

    public function DefaultLayout() {
      super();
      display.stage.addEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event) : void {
      this.layoutWidgets();
    }

    public function onWidgetChanged(param1:Widget) : void {
      this.layoutWidgets();
    }

    public function layoutWidgets() : void {
      var local3:DisplayObject = null;
      var local1:int = int(display.stage.stageWidth);
      var local2:int = 0;
      while(local2 < this.widgets.length) {
        local3 = DisplayObject(this.widgets[local2]);
        local3.x = local1 - local3.width - 10;
        local3.y = display.stage.stageHeight - local3.height - 10;
        local1 = local3.x;
        local2++;
      }
      battleGUIService.setPositionXDefaultLayout(local1);
    }

    public function addWidget(param1:Widget) : void {
      if(this.initialized) {
        this.widgets.push(param1);
      } else {
        this.deferred.push(param1);
      }
      param1.setLayoutManager(this);
      this.onWidgetChanged(param1);
    }

    public function addWidget2(param1:Widget) : void {
      this.widgets.push(param1);
      param1.setLayoutManager(this);
    }

    public function destroy() : void {
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
      this.removeWidgets();
    }

    private function removeWidgets() : void {
      var local1:Widget = null;
      var local2:DisplayObject = null;
      for each(local1 in this.widgets) {
        local2 = DisplayObject(local1);
        if(local2.parent != null) {
          local2.parent.removeChild(local2);
        }
      }
    }

    public function init() : void {
      var local1:Widget = null;
      if(!this.initialized) {
        this.initialized = true;
        for each(local1 in this.deferred) {
          this.widgets.push(local1);
        }
        this.deferred = null;
      }
      this.layoutWidgets();
    }
  }
}
