package org.robotlegs.base {
  import flash.events.Event;

  public class ContextEvent extends Event {
    public static const STARTUP:String = "startup";
    public static const STARTUP_COMPLETE:String = "startupComplete";
    public static const SHUTDOWN:String = "shutdown";
    public static const SHUTDOWN_COMPLETE:String = "shutdownComplete";

    protected var _body:*;

    public function ContextEvent(type:String, body:* = null) {
      super(type);
      this._body = body;
    }

    public function get body() : * {
      return this._body;
    }

    override public function clone() : Event {
      return new ContextEvent(type,this.body);
    }
  }
}
