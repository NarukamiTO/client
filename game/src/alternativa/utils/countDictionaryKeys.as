package alternativa.utils {
  import flash.utils.Dictionary;

  public function countDictionaryKeys(param1:Dictionary) : int {
    var local3:* = undefined;
    var local2:int = 0;
    for(local3 in param1) {
      local2++;
    }
    return local2;
  }
}
