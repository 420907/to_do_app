class ToDo{
  String desc;
  bool _isCompleted = false;
  bool _isDragging = false;
  ToDo(this.desc);

  ToDo.copy(ToDo other)
      : this.desc = other.desc,
        this._isCompleted = other._isCompleted,
        this._isDragging = other._isDragging;

  @override
  String toString() {
    return desc;
  }

  get isDragging => _isDragging;
  get isComplete => _isCompleted;

  set isComplete(bool completed){
    _isCompleted = completed;
  }

  set isDragged(bool isDragStarted){
    _isDragging = isDragStarted;
  }
}