package factory.exception;

public class AllocateCarForRecordConflict extends RuntimeException{

	/***/
	private static final long serialVersionUID = 1L;

	public AllocateCarForRecordConflict(String message){
		super(message);
	}

}
