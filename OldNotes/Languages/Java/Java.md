## JVM (Java Virtual Machine)
>Is an abstract machine that can run a low level code called bytecode.<br>
The process of execute a java code is based on :

1. **Compiler** : Compile the java code and convert into bytecode.
2. **Interpreter** : Is specific for each platform and convert the bytecode into machine code.

## OOP (Object Oriented Programming)
>Is a programming paradigm based on the concept of `objects`,`attributes `and `methods`.<br>

Characteristics :
>1. **Abstraction** :<br>
Is a practise that allow to focus on the behavior and characteristics ignoring the implementation details.

In Java abstraction is implemented using `abstract classes` and `interfaces`:
- **Abstract class** : 
  - Is `extended` by a class
  - Is a class that can't be instantiated
  - it can have abstract methods and non abstract methods.
  - Don't obbligate the class to implement all the methods of the abstract class
```java
public abstract class AbstractClass {
    public abstract void abstractMethod();
    public void nonAbstractMethod(){
        System.out.println("This is a non abstract method");
    }
}
```
- **Interface** : 
  - Is `implemented` by a class
  - Obligate the class to implement all the methods of the interface
  - It can have only abstract methods.
```java
public interface Interface {
    public void abstractMethod();
}
```

>2. **Encapsulation** :<br>
Have the purpose of hiding attributes or methods inside a class, preventing unauthorized access from outside.

In Java encapsulation is implemented using the scope modifiers :

| Modifiers | Class | Package | Subclass | Universal |
|:---------:|:-----:|:-------:|:--------:|:---------:|
|  private  |   x   |         |          |           |
|  default  |   x   |    x    |          |           |
| protected |   x   |    x    |          |           |
|  public   |   x   |    x    |    x     |     x     |


>3. **Inheritance** :<br>
Is the process of creating new classes from existing classes.


It allows to :
- Reuse attributes and methods
- Rewrite methods
- Specialize classes

In Java inheritance is implemented using the keyword `extends` :

```java
public class ChildClass extends ParentClass {
    //code
    @Override // to override parent method
    public void parentMethod(){
        //code
    }
}
```

>4. **Polymorphism** :<br>
Is the process of rewrite or using a method in different ways for different data input.

In Java Polymorphism is implemented using :
- **Overloading** : 
  - Is the process of using the same method name with different parameters.
  - Don't need to override.
  - The method signature must be different.
  - The return type can be different.
  - The access modifier can be different.

- **Overriding** : 
  - Is the process of using the same method name with the same parameters.
  - Need `@Override`
  - The method signature must be the same.
  - The return type must be the same.
  - The access modifier can't be more restrictive.




