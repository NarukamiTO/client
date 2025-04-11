package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import flash.display.DisplayObject;

  public function removeDisplayObject(param1:DisplayObject) : void {
    if(param1 != null && param1.parent != null) {
      param1.parent.removeChild(param1);
    }
  }
}
