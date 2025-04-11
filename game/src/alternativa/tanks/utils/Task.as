package alternativa.tanks.utils {
  public class Task {
    private var _taskSequence:TaskSequence;

    public function Task() {
      super();
    }

    public function run() : void {
    }

    internal function set taskSequence(param1:TaskSequence) : void {
      this._taskSequence = param1;
    }

    final protected function completeTask() : void {
      this._taskSequence.taskComplete(this);
    }
  }
}
