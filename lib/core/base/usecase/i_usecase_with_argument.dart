abstract class IUseCaseWithArgument<E, T> {
  Future<T> execute(E e);
}
