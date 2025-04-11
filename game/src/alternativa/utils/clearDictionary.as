package alternativa.utils {
  import flash.utils.Dictionary;

  public function clearDictionary(param1:Dictionary) : void {
    var local2:* = undefined;
    for(local2 in param1) {
      delete param1[local2];
    }
  }
}
