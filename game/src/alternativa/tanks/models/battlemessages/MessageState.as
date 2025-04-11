package alternativa.tanks.models.battlemessages {
  internal interface MessageState {
    function init() : void;
    function setDurationInMs(param1:int) : void;
    function update(param1:int) : Boolean;
  }
}
