package org.osflash.signals.events {
  public interface IBubbleEventHandler {
    function onEventBubbled(event:IEvent) : Boolean;
  }
}
