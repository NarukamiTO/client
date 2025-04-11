package org.osflash.signals.events {
  import org.osflash.signals.IPrioritySignal;

  public class GenericEvent implements IEvent {
    protected var _bubbles:Boolean;
    protected var _target:Object;
    protected var _currentTarget:Object;
    protected var _signal:IPrioritySignal;

    public function GenericEvent(bubbles:Boolean = false) {
      super();
      this._bubbles = bubbles;
    }

    public function get signal() : IPrioritySignal {
      return this._signal;
    }

    public function set signal(value:IPrioritySignal) : void {
      this._signal = value;
    }

    public function get target() : Object {
      return this._target;
    }

    public function set target(value:Object) : void {
      this._target = value;
    }

    public function get currentTarget() : Object {
      return this._currentTarget;
    }

    public function set currentTarget(value:Object) : void {
      this._currentTarget = value;
    }

    public function get bubbles() : Boolean {
      return this._bubbles;
    }

    public function set bubbles(value:Boolean) : void {
      this._bubbles = value;
    }

    public function clone() : IEvent {
      return new GenericEvent(this._bubbles);
    }
  }
}
