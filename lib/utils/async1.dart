// How Async Work

Future<int> cube(int num){
  // Future.delayed(Duration(seconds:2), (){

  // }
  return Future.value(num*num*num);
}


asyncTask(){
  print("I am the First Line");
  Future.delayed(Duration(seconds: 5),(){
       print("I will Call After 5 sec");   
       return 1000;
  });
  print("I am the Last Line");
}




void main(){
  print("I am First ");
  Future<int> future = cube(3);
  future.then((value) => print(value)).catchError((err)=>print(err));
  //asyncTask();
  print("Bye Bye main...");
}