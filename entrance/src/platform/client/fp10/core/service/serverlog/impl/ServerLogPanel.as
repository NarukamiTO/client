package platform.client.fp10.core.service.serverlog.impl {
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.system.System;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.ui.Keyboard;

  public class ServerLogPanel {
    private var textFormat:TextFormat = new TextFormat("Courier",14);
    private var textColor:uint = 0;
    private var bgColor:uint = 14540253;
    private var stage:Stage;
    private var btnShowLog:ErrorLogButton;
    private var btnCloseLog:ErrorLogButton;
    private var btnCopyLog:ErrorLogButton;
    private var btnClearLog:ErrorLogButton;
    private var container:Sprite;
    private var output:Sprite;
    private var levelFilter:Object = {};
    private var entries:Vector.<LogEntry> = new Vector.<LogEntry>();
    private var filteredEntries:Vector.<LogEntry> = new Vector.<LogEntry>();
    private var logLevels:Array = [];
    private var textFields:Vector.<TextField> = new Vector.<TextField>();
    private var filterButtons:Vector.<FilterButton> = new Vector.<FilterButton>();
    private var charWidth:int;
    private var charHeight:int;
    private var hSpacing:int = 2;
    private var numLines:int;
    private var lineWidth:int;
    private var currentLine:int;

    public function ServerLogPanel(param1:Stage) {
      super();
      this.stage = param1;
      this.container = new Sprite();
      this.btnShowLog = new ErrorLogButton("[Click to view server log messages]",16776960,16711680);
      this.btnShowLog.addEventListener(MouseEvent.CLICK,this.onBtnShowLogClick);
      this.btnCloseLog = new ErrorLogButton("[Close]",65280,0);
      this.btnCloseLog.addEventListener(MouseEvent.CLICK,this.onBtnCloseClick);
      this.container.addChild(this.btnCloseLog);
      this.btnCopyLog = new ErrorLogButton("[Copy to clipboard]",65280,0);
      this.btnCopyLog.addEventListener(MouseEvent.CLICK,this.onBtnCopyClick);
      this.btnCopyLog.x = this.btnCloseLog.width;
      this.container.addChild(this.btnCopyLog);
      this.btnClearLog = new ErrorLogButton("[Clear]",65280,0);
      this.btnClearLog.addEventListener(MouseEvent.CLICK,this.onBtnClearClick);
      this.btnClearLog.x = this.btnCopyLog.x + this.btnCopyLog.width;
      this.container.addChild(this.btnClearLog);
      this.container.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
      this.container.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      this.output = new Sprite();
      this.container.addChild(this.output);
      param1.addEventListener(Event.RESIZE,this.onStageResize);
      this.calcTextMetrics(param1);
      this.onStageResize(null);
    }

    public function addLogMessage(param1:String, param2:String) : void {
      var local6:String = null;
      var local7:int = 0;
      this.updateLogLevels(param1);
      var local3:int = this.currentLine;
      var local4:int = this.lineWidth - param1.length - 3;
      var local5:Array = param2.split(/\n|\r|\n\r/);
      for each(local6 in local5) {
        local7 = 0;
        while(local7 < local6.length) {
          this.addLogEntry(new LogEntry(param1,local6.substr(local7,local4)));
          local7 += local4;
        }
      }
      if(this.container.parent == null) {
        this.stage.addChild(this.btnShowLog);
      } else if(local3 != this.currentLine) {
        this.updateOutput();
      }
    }

    private function addLogEntry(param1:LogEntry) : void {
      this.entries.push(param1);
      if(this.levelFilter[param1.logLevel] != null) {
        this.filteredEntries.push(param1);
        if(this.currentLine == this.filteredEntries.length - 1) {
          this.currentLine = this.filteredEntries.length;
        }
      }
    }

    private function updateOutput() : void {
      if(this.container.parent != null) {
        this.printEntries(this.filteredEntries,this.currentLine);
      }
    }

    private function calcTextMetrics(param1:Stage) : void {
      var local2:TextField = new TextField();
      local2.defaultTextFormat = this.textFormat;
      local2.text = "a";
      param1.addChild(local2);
      this.charWidth = local2.textWidth;
      this.charHeight = local2.textHeight;
      param1.removeChild(local2);
    }

    private function resizeOutput(param1:int, param2:int) : void {
      this.numLines = param2 / (this.charHeight + this.hSpacing);
      this.lineWidth = param1 / this.charWidth;
      this.updateTextFields(param1);
      this.scrollOutput(0);
      var local3:Graphics = this.output.graphics;
      local3.clear();
      local3.beginFill(this.bgColor);
      local3.drawRect(0,0,param1,param2);
      local3.endFill();
    }

    private function updateTextFields(param1:int) : void {
      var local4:TextField = null;
      while(this.textFields.length > this.numLines) {
        this.output.removeChild(this.textFields.pop());
      }
      while(this.textFields.length < this.numLines) {
        this.createTextField();
      }
      var local2:int = this.charHeight + this.hSpacing;
      var local3:int = 0;
      while(local3 < this.textFields.length) {
        local4 = this.textFields[local3];
        local4.y = local3 * local2;
        local4.width = param1;
        local3++;
      }
    }

    private function createTextField() : void {
      var local1:TextField = new TextField();
      local1.textColor = this.textColor;
      local1.defaultTextFormat = this.textFormat;
      this.output.addChild(local1);
      this.textFields.push(local1);
    }

    private function printEntries(param1:Vector.<LogEntry>, param2:int) : void {
      var local4:int = 0;
      var local5:LogEntry = null;
      var local3:int = param2 - this.numLines;
      if(local3 < 0) {
        local3 = 0;
      } else {
        param2 = this.numLines;
      }
      local4 = 0;
      while(local4 < param2) {
        local5 = param1[local3 + local4];
        this.textFields[local4].text = local5.toString();
        local4++;
      }
      while(local4 < this.numLines) {
        this.textFields[local4++].text = "";
      }
    }

    private function filterByLevels() : void {
      var local1:LogEntry = null;
      this.filteredEntries.length = 0;
      for each(local1 in this.entries) {
        if(this.levelFilter[local1.logLevel] != null) {
          this.filteredEntries.push(local1);
        }
      }
      this.scrollOutput(0);
    }

    private function updateLogLevels(param1:String) : void {
      var local3:FilterButton = null;
      var local2:int = int(this.logLevels.indexOf(param1));
      if(local2 < 0) {
        this.logLevels.push(param1);
        this.logLevels.sort();
        this.levelFilter[param1] = true;
        local3 = new FilterButton("[" + param1 + "]",65280,21760,0,param1);
        this.container.addChild(local3);
        local3.addEventListener(MouseEvent.CLICK,this.onFilterButtonClick);
        local3.y = 20;
        this.filterButtons.push(local3);
        this.filterButtons.sort(this.filterSort);
        this.updateFilterButtons();
      }
    }

    private function updateFilterButtons() : void {
      var local2:FilterButton = null;
      var local1:int = 0;
      for each(local2 in this.filterButtons) {
        local2.x = local1;
        local1 += local2.width;
      }
    }

    private function filterSort(param1:FilterButton, param2:FilterButton) : Number {
      if(param1.filterString == param2.filterString) {
        return 0;
      }
      if(param1.filterString > param2.filterString) {
        return 1;
      }
      return -1;
    }

    private function onFilterButtonClick(param1:MouseEvent) : void {
      var local2:FilterButton = FilterButton(param1.target);
      local2.active = !local2.active;
      if(local2.active) {
        this.levelFilter[local2.filterString] = true;
      } else {
        delete this.levelFilter[local2.filterString];
      }
      this.filterByLevels();
      this.updateOutput();
    }

    private function onBtnShowLogClick(param1:Event) : void {
      this.stage.removeChild(this.btnShowLog);
      this.stage.addChild(this.container);
      this.onStageResize(null);
    }

    private function onStageResize(param1:Event) : void {
      var local2:int = 40;
      this.output.y = local2;
      this.resizeOutput(this.stage.stageWidth,this.stage.stageHeight - local2);
      this.printEntries(this.filteredEntries,this.currentLine);
    }

    private function onBtnCloseClick(param1:Event) : void {
      this.stage.removeChild(this.container);
      this.stage.focus = this.stage;
    }

    private function onBtnCopyClick(param1:Event) : void {
      var local3:LogEntry = null;
      var local2:String = "";
      for each(local3 in this.filteredEntries) {
        local2 += local3.toString() + "\n";
      }
      System.setClipboard(local2);
    }

    private function onBtnClearClick(param1:Event) : void {
      var local2:FilterButton = null;
      this.entries.length = 0;
      this.filteredEntries.length = 0;
      for each(local2 in this.filterButtons) {
        local2.removeEventListener(MouseEvent.CLICK,this.onFilterButtonClick);
        this.container.removeChild(local2);
      }
      this.filterButtons.length = 0;
      this.logLevels.length = 0;
      this.levelFilter = {};
      this.currentLine = 0;
      this.updateOutput();
    }

    private function onKey(param1:KeyboardEvent) : void {
      switch(param1.keyCode) {
        case Keyboard.PAGE_UP:
          this.scrollOutput(-this.numLines);
          break;
        case Keyboard.PAGE_DOWN:
          this.scrollOutput(this.numLines);
      }
    }

    private function scrollOutput(param1:int) : void {
      this.currentLine += param1;
      if(this.currentLine < this.numLines) {
        this.currentLine = this.numLines;
      }
      if(this.currentLine > this.filteredEntries.length) {
        this.currentLine = this.filteredEntries.length;
      }
      this.updateOutput();
    }

    private function onMouseWheel(param1:MouseEvent) : void {
      this.scrollOutput(-param1.delta);
    }
  }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
class LogEntry {
  public var logLevel:String;
  public var text:String;

  public function LogEntry(param1:String, param2:String) {
    super();
    this.logLevel = param1;
    this.text = param2;
  }

  public function toString() : String {
    return "[" + this.logLevel + "] " + this.text;
  }
}

class ErrorLogButton extends Sprite {
  private var label:TextField;
  public function ErrorLogButton(param1:String, param2:uint, param3:uint) {
    super();
    mouseChildren = false;
    buttonMode = true;
    this.label = new TextField();
    this.label.defaultTextFormat = new TextFormat("Tahoma",12,param2);
    this.label.autoSize = TextFieldAutoSize.LEFT;
    this.label.text = param1;
    this.label.background = true;
    this.label.backgroundColor = param3;
    addChild(this.label);
  }
}

class FilterButton extends Sprite {
  public var filterString:String;

  private var _active:Boolean = true;
  private var label:TextField;
  private var activeBgColor:uint;
  private var inactiveBgColor:uint;

  public function FilterButton(param1:String, param2:uint, param3:uint, param4:uint, param5:String) {
    super();
    this.activeBgColor = param3;
    this.inactiveBgColor = param4;
    this.filterString = param5;
    mouseChildren = false;
    buttonMode = true;
    this.label = new TextField();
    this.label.defaultTextFormat = new TextFormat("Tahoma",12,param2);
    this.label.autoSize = TextFieldAutoSize.LEFT;
    this.label.text = param1;
    this.label.background = true;
    this.label.backgroundColor = param3;
    addChild(this.label);
  }

  public function get active() : Boolean {
    return this._active;
  }

  public function set active(param1:Boolean) : void {
    this._active = param1;
    this.label.backgroundColor = !!this._active ? uint(this.activeBgColor) : uint(this.inactiveBgColor);
  }
}
