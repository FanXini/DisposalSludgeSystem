package factory.exception;

public class RefuseLoginException extends RuntimeException{

	/***/
	private static final long serialVersionUID = 1L;

	public RefuseLoginException(String message) {
		super(message);	
	}

}
