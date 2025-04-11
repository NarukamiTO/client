package fl.managers {
  import fl.controls.Button;
  import fl.core.UIComponent;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.InteractiveObject;
  import flash.display.SimpleButton;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldType;
  import flash.ui.Keyboard;
  import flash.utils.*;

  public class FocusManager implements IFocusManager {
    private var focusableObjects:Dictionary;
    private var _showFocusIndicator:Boolean = true;
    private var defButton:Button;
    private var focusableCandidates:Array;
    private var _form:DisplayObjectContainer;
    private var _defaultButtonEnabled:Boolean = true;
    private var activated:Boolean = false;
    private var _defaultButton:Button;
    private var calculateCandidates:Boolean = true;
    private var lastFocus:InteractiveObject;
    private var lastAction:String;

    public function FocusManager(param1:DisplayObjectContainer) {
      super();
      focusableObjects = new Dictionary(true);
      if(param1 != null) {
        _form = param1;
        addFocusables(DisplayObject(param1));
        param1.addEventListener(Event.ADDED,addedHandler);
        param1.addEventListener(Event.REMOVED,removedHandler);
        activate();
      }
    }

    public function get showFocusIndicator() : Boolean {
      return _showFocusIndicator;
    }

    private function getIndexOfNextObject(param1:int, param2:Boolean, param3:Boolean, param4:String) : int {
      var local7:DisplayObject = null;
      var local8:IFocusManagerGroup = null;
      var local9:int = 0;
      var local10:DisplayObject = null;
      var local11:IFocusManagerGroup = null;
      var local5:int = int(focusableCandidates.length);
      var local6:int = param1;
      while(true) {
        if(param2) {
          param1--;
        } else {
          param1++;
        }
        if(param3) {
          if(param2 && param1 < 0) {
            break;
          }
          if(!param2 && param1 == local5) {
            break;
          }
        } else {
          param1 = (param1 + local5) % local5;
          if(local6 == param1) {
            break;
          }
        }
        if(isValidFocusCandidate(focusableCandidates[param1],param4)) {
          local7 = DisplayObject(findFocusManagerComponent(focusableCandidates[param1]));
          if(local7 is IFocusManagerGroup) {
            local8 = IFocusManagerGroup(local7);
            local9 = 0;
            while(local9 < focusableCandidates.length) {
              local10 = focusableCandidates[local9];
              if(local10 is IFocusManagerGroup) {
                local11 = IFocusManagerGroup(local10);
                if(local11.groupName == local8.groupName && Boolean(local11.selected)) {
                  param1 = local9;
                  break;
                }
              }
              local9++;
            }
          }
          return param1;
        }
      }
      return param1;
    }

    private function mouseFocusChangeHandler(param1:FocusEvent) : void {
      if(param1.relatedObject is TextField) {
        return;
      }
      param1.preventDefault();
    }

    public function set form(param1:DisplayObjectContainer) : void {
      _form = param1;
    }

    private function addFocusables(param1:DisplayObject, param2:Boolean = false) : void {
      var focusable:IFocusManagerComponent = null;
      var io:InteractiveObject = null;
      var doc:DisplayObjectContainer = null;
      var i:int = 0;
      var child:DisplayObject = null;
      var o:DisplayObject = param1;
      var skipTopLevel:Boolean = param2;
      if(!skipTopLevel) {
        if(o is IFocusManagerComponent) {
          focusable = IFocusManagerComponent(o);
          if(focusable.focusEnabled) {
            if(Boolean(focusable.tabEnabled) && isTabVisible(o)) {
              focusableObjects[o] = true;
              calculateCandidates = true;
            }
            o.addEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
            o.addEventListener(Event.TAB_INDEX_CHANGE,tabIndexChangeHandler);
          }
        } else if(o is InteractiveObject) {
          io = o as InteractiveObject;
          if(io && io.tabEnabled && findFocusManagerComponent(io) == io) {
            focusableObjects[io] = true;
            calculateCandidates = true;
          }
          io.addEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
          io.addEventListener(Event.TAB_INDEX_CHANGE,tabIndexChangeHandler);
        }
      }
      if(o is DisplayObjectContainer) {
        doc = DisplayObjectContainer(o);
        o.addEventListener(Event.TAB_CHILDREN_CHANGE,tabChildrenChangeHandler);
        if(doc is Stage || doc.parent is Stage || doc.tabChildren) {
          i = 0;
          while(i < doc.numChildren) {
            try {
              child = doc.getChildAt(i);
              if(child != null) {
                addFocusables(doc.getChildAt(i));
              }
            }
            catch(error:SecurityError) {
            }
            i++;
          }
        }
      }
    }

    private function getChildIndex(param1:DisplayObjectContainer, param2:DisplayObject) : int {
      return param1.getChildIndex(param2);
    }

    public function findFocusManagerComponent(param1:InteractiveObject) : InteractiveObject {
      var local2:InteractiveObject = param1;
      while(Boolean(param1)) {
        if(param1 is IFocusManagerComponent && Boolean(IFocusManagerComponent(param1).focusEnabled)) {
          return param1;
        }
        param1 = param1.parent;
      }
      return local2;
    }

    private function focusOutHandler(param1:FocusEvent) : void {
      var local2:InteractiveObject = param1.target as InteractiveObject;
    }

    private function isValidFocusCandidate(param1:DisplayObject, param2:String) : Boolean {
      var local3:IFocusManagerGroup = null;
      if(!isEnabledAndVisible(param1)) {
        return false;
      }
      if(param1 is IFocusManagerGroup) {
        local3 = IFocusManagerGroup(param1);
        if(param2 == local3.groupName) {
          return false;
        }
      }
      return true;
    }

    private function setFocusToNextObject(param1:FocusEvent) : void {
      if(!hasFocusableObjects()) {
        return;
      }
      var local2:InteractiveObject = getNextFocusManagerComponent(param1.shiftKey);
      if(Boolean(local2)) {
        setFocus(local2);
      }
    }

    private function sortFocusableObjectsTabIndex() : void {
      var local1:Object = null;
      var local2:InteractiveObject = null;
      focusableCandidates = [];
      for(local1 in focusableObjects) {
        local2 = InteractiveObject(local1);
        if(Boolean(local2.tabIndex) && !isNaN(Number(local2.tabIndex))) {
          focusableCandidates.push(local2);
        }
      }
      focusableCandidates.sort(sortByTabIndex);
    }

    private function removeFocusables(param1:DisplayObject) : void {
      var local2:Object = null;
      var local3:DisplayObject = null;
      if(param1 is DisplayObjectContainer) {
        param1.removeEventListener(Event.TAB_CHILDREN_CHANGE,tabChildrenChangeHandler);
        param1.removeEventListener(Event.TAB_INDEX_CHANGE,tabIndexChangeHandler);
        for(local2 in focusableObjects) {
          local3 = DisplayObject(local2);
          if(DisplayObjectContainer(param1).contains(local3)) {
            if(local3 == lastFocus) {
              lastFocus = null;
            }
            local3.removeEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
            delete focusableObjects[local2];
            calculateCandidates = true;
          }
        }
      }
    }

    private function getTopLevelFocusTarget(param1:InteractiveObject) : InteractiveObject {
      while(param1 != InteractiveObject(form)) {
        if(param1 is IFocusManagerComponent && Boolean(IFocusManagerComponent(param1).focusEnabled) && Boolean(IFocusManagerComponent(param1).mouseFocusEnabled) && UIComponent(param1).enabled) {
          return param1;
        }
        param1 = param1.parent;
        if(param1 == null) {
          break;
        }
      }
      return null;
    }

    public function sendDefaultButtonEvent() : void {
      defButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }

    private function addedHandler(param1:Event) : void {
      var local2:DisplayObject = DisplayObject(param1.target);
      if(Boolean(local2.stage)) {
        addFocusables(DisplayObject(param1.target));
      }
    }

    private function isEnabledAndVisible(param1:DisplayObject) : Boolean {
      var local3:TextField = null;
      var local4:SimpleButton = null;
      var local2:DisplayObjectContainer = DisplayObject(form).parent;
      while(param1 != local2) {
        if(param1 is UIComponent) {
          if(!UIComponent(param1).enabled) {
            return false;
          }
        } else if(param1 is TextField) {
          local3 = TextField(param1);
          if(local3.type == TextFieldType.DYNAMIC || !local3.selectable) {
            return false;
          }
        } else if(param1 is SimpleButton) {
          local4 = SimpleButton(param1);
          if(!local4.enabled) {
            return false;
          }
        }
        if(!param1.visible) {
          return false;
        }
        param1 = param1.parent;
      }
      return true;
    }

    private function tabChildrenChangeHandler(param1:Event) : void {
      if(param1.target != param1.currentTarget) {
        return;
      }
      calculateCandidates = true;
      var local2:DisplayObjectContainer = DisplayObjectContainer(param1.target);
      if(local2.tabChildren) {
        addFocusables(local2,true);
      } else {
        removeFocusables(local2);
      }
    }

    private function deactivateHandler(param1:Event) : void {
      var local2:InteractiveObject = InteractiveObject(param1.target);
    }

    public function setFocus(param1:InteractiveObject) : void {
      if(param1 is IFocusManagerComponent) {
        IFocusManagerComponent(param1).setFocus();
      } else {
        form.stage.focus = param1;
      }
    }

    public function getFocus() : InteractiveObject {
      var local1:InteractiveObject = form.stage.focus;
      return findFocusManagerComponent(local1);
    }

    private function hasFocusableObjects() : Boolean {
      var local1:Object = null;
      var local2:int = 0;
      var local3:* = focusableObjects;
      for(local1 in local3) {
        return true;
      }
      return false;
    }

    private function tabIndexChangeHandler(param1:Event) : void {
      calculateCandidates = true;
    }

    public function set defaultButton(param1:Button) : void {
      var local2:Button = Boolean(param1) ? Button(param1) : null;
      if(local2 != _defaultButton) {
        if(Boolean(_defaultButton)) {
          _defaultButton.emphasized = false;
        }
        if(Boolean(defButton)) {
          defButton.emphasized = false;
        }
        _defaultButton = local2;
        defButton = local2;
        if(Boolean(local2)) {
          local2.emphasized = true;
        }
      }
    }

    private function sortFocusableObjects() : void {
      var local1:Object = null;
      var local2:InteractiveObject = null;
      focusableCandidates = [];
      for(local1 in focusableObjects) {
        local2 = InteractiveObject(local1);
        if(local2.tabIndex && !isNaN(Number(local2.tabIndex)) && local2.tabIndex > 0) {
          sortFocusableObjectsTabIndex();
          return;
        }
        focusableCandidates.push(local2);
      }
      focusableCandidates.sort(sortByDepth);
    }

    private function keyFocusChangeHandler(param1:FocusEvent) : void {
      showFocusIndicator = true;
      if((param1.keyCode == Keyboard.TAB || param1.keyCode == 0) && !param1.isDefaultPrevented()) {
        setFocusToNextObject(param1);
        param1.preventDefault();
      }
    }

    private function getIndexOfFocusedObject(param1:DisplayObject) : int {
      var local2:int = int(focusableCandidates.length);
      var local3:int = 0;
      local3 = 0;
      while(local3 < local2) {
        if(focusableCandidates[local3] == param1) {
          return local3;
        }
        local3++;
      }
      return -1;
    }

    public function hideFocus() : void {
    }

    private function removedHandler(param1:Event) : void {
      var local2:int = 0;
      var local4:InteractiveObject = null;
      var local3:DisplayObject = DisplayObject(param1.target);
      if(local3 is IFocusManagerComponent && focusableObjects[local3] == true) {
        if(local3 == lastFocus) {
          IFocusManagerComponent(lastFocus).drawFocus(false);
          lastFocus = null;
        }
        local3.removeEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
        delete focusableObjects[local3];
        calculateCandidates = true;
      } else if(local3 is InteractiveObject && focusableObjects[local3] == true) {
        local4 = local3 as InteractiveObject;
        if(Boolean(local4)) {
          if(local4 == lastFocus) {
            lastFocus = null;
          }
          delete focusableObjects[local4];
          calculateCandidates = true;
        }
        local3.addEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
      }
      removeFocusables(local3);
    }

    private function sortByDepth(param1:InteractiveObject, param2:InteractiveObject) : Number {
      var local5:int = 0;
      var local6:String = null;
      var local7:String = null;
      var local3:String = "";
      var local4:String = "";
      var local8:String = "0000";
      var local9:DisplayObject = DisplayObject(param1);
      var local10:DisplayObject = DisplayObject(param2);
      while(local9 != DisplayObject(form) && Boolean(local9.parent)) {
        local5 = getChildIndex(local9.parent,local9);
        local6 = local5.toString(16);
        if(local6.length < 4) {
          local7 = local8.substring(0,4 - local6.length) + local6;
        }
        local3 = local7 + local3;
        local9 = local9.parent;
      }
      while(local10 != DisplayObject(form) && Boolean(local10.parent)) {
        local5 = getChildIndex(local10.parent,local10);
        local6 = local5.toString(16);
        if(local6.length < 4) {
          local7 = local8.substring(0,4 - local6.length) + local6;
        }
        local4 = local7 + local4;
        local10 = local10.parent;
      }
      return local3 > local4 ? 1 : (local3 < local4 ? -1 : 0);
    }

    public function get defaultButton() : Button {
      return _defaultButton;
    }

    private function activateHandler(param1:Event) : void {
      var local2:InteractiveObject = InteractiveObject(param1.target);
      if(Boolean(lastFocus)) {
        if(lastFocus is IFocusManagerComponent) {
          IFocusManagerComponent(lastFocus).setFocus();
        } else {
          form.stage.focus = lastFocus;
        }
      }
      lastAction = "ACTIVATE";
    }

    public function showFocus() : void {
    }

    public function set defaultButtonEnabled(param1:Boolean) : void {
      _defaultButtonEnabled = param1;
    }

    public function getNextFocusManagerComponent(param1:Boolean = false) : InteractiveObject {
      var local8:IFocusManagerGroup = null;
      if(!hasFocusableObjects()) {
        return null;
      }
      if(calculateCandidates) {
        sortFocusableObjects();
        calculateCandidates = false;
      }
      var local2:DisplayObject = form.stage.focus;
      local2 = DisplayObject(findFocusManagerComponent(InteractiveObject(local2)));
      var local3:String = "";
      if(local2 is IFocusManagerGroup) {
        local8 = IFocusManagerGroup(local2);
        local3 = local8.groupName;
      }
      var local4:int = getIndexOfFocusedObject(local2);
      var local5:Boolean = false;
      var local6:int = local4;
      if(local4 == -1) {
        if(param1) {
          local4 = int(focusableCandidates.length);
        }
        local5 = true;
      }
      var local7:int = getIndexOfNextObject(local4,param1,local5,local3);
      return findFocusManagerComponent(focusableCandidates[local7]);
    }

    private function mouseDownHandler(param1:MouseEvent) : void {
      if(param1.isDefaultPrevented()) {
        return;
      }
      var local2:InteractiveObject = getTopLevelFocusTarget(InteractiveObject(param1.target));
      if(!local2) {
        return;
      }
      showFocusIndicator = false;
      if((local2 != lastFocus || lastAction == "ACTIVATE") && !(local2 is TextField)) {
        setFocus(local2);
      }
      lastAction = "MOUSEDOWN";
    }

    private function isTabVisible(param1:DisplayObject) : Boolean {
      var local2:DisplayObjectContainer = param1.parent;
      while(local2 && !(local2 is Stage) && !(local2.parent && local2.parent is Stage)) {
        if(!local2.tabChildren) {
          return false;
        }
        local2 = local2.parent;
      }
      return true;
    }

    public function get nextTabIndex() : int {
      return 0;
    }

    private function keyDownHandler(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.TAB) {
        lastAction = "KEY";
        if(calculateCandidates) {
          sortFocusableObjects();
          calculateCandidates = false;
        }
      }
      if(defaultButtonEnabled && param1.keyCode == Keyboard.ENTER && defaultButton && defButton.enabled) {
        sendDefaultButtonEvent();
      }
    }

    private function focusInHandler(param1:FocusEvent) : void {
      var local3:Button = null;
      var local2:InteractiveObject = InteractiveObject(param1.target);
      if(form.contains(local2)) {
        lastFocus = findFocusManagerComponent(InteractiveObject(local2));
        if(lastFocus is Button) {
          local3 = Button(lastFocus);
          if(Boolean(defButton)) {
            defButton.emphasized = false;
            defButton = local3;
            local3.emphasized = true;
          }
        } else if(Boolean(defButton) && defButton != _defaultButton) {
          defButton.emphasized = false;
          defButton = _defaultButton;
          _defaultButton.emphasized = true;
        }
      }
    }

    private function tabEnabledChangeHandler(param1:Event) : void {
      calculateCandidates = true;
      var local2:InteractiveObject = InteractiveObject(param1.target);
      var local3:Boolean = focusableObjects[local2] == true;
      if(local2.tabEnabled) {
        if(!local3 && isTabVisible(local2)) {
          if(!(local2 is IFocusManagerComponent)) {
            local2.focusRect = false;
          }
          focusableObjects[local2] = true;
        }
      } else if(local3) {
        delete focusableObjects[local2];
      }
    }

    public function set showFocusIndicator(param1:Boolean) : void {
      _showFocusIndicator = param1;
    }

    public function get form() : DisplayObjectContainer {
      return _form;
    }

    private function sortByTabIndex(param1:InteractiveObject, param2:InteractiveObject) : int {
      return param1.tabIndex > param2.tabIndex ? 1 : (param1.tabIndex < param2.tabIndex ? -1 : int(sortByDepth(param1,param2)));
    }

    public function get defaultButtonEnabled() : Boolean {
      return _defaultButtonEnabled;
    }

    public function activate() : void {
      if(activated) {
        return;
      }
      form.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,mouseFocusChangeHandler,false,0,true);
      form.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,keyFocusChangeHandler,false,0,true);
      form.addEventListener(FocusEvent.FOCUS_IN,focusInHandler,true);
      form.addEventListener(FocusEvent.FOCUS_OUT,focusOutHandler,true);
      form.stage.addEventListener(Event.ACTIVATE,activateHandler,false,0,true);
      form.stage.addEventListener(Event.DEACTIVATE,deactivateHandler,false,0,true);
      form.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
      form.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler,true);
      activated = true;
      if(Boolean(lastFocus)) {
        setFocus(lastFocus);
      }
    }

    public function deactivate() : void {
      form.stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,mouseFocusChangeHandler);
      form.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,keyFocusChangeHandler);
      form.removeEventListener(FocusEvent.FOCUS_IN,focusInHandler,true);
      form.removeEventListener(FocusEvent.FOCUS_OUT,focusOutHandler,true);
      form.stage.removeEventListener(Event.ACTIVATE,activateHandler);
      form.stage.removeEventListener(Event.DEACTIVATE,deactivateHandler);
      form.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
      form.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler,true);
      activated = false;
    }
  }
}
