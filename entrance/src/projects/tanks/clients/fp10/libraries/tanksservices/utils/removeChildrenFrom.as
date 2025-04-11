package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import flash.display.DisplayObjectContainer;

  public function removeChildrenFrom(param1:DisplayObjectContainer) : void {
    while(param1.numChildren > 0) {
      param1.removeChildAt(param1.numChildren - 1);
    }
  }
}
