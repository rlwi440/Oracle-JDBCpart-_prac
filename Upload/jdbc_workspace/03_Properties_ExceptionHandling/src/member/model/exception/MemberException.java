package member.model.exception;
/**
 * checkedException : extends,Exception 
 * uncheckedException :extends, RuntimeException
 * @author rlwi4
 *
 */

public class MemberException extends RuntimeException {		
	//RuntimeException을 상속하지 않는 클래스는 Checked Exception
	public MemberException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		// TODO Auto-generated constructor stub
	}

	public MemberException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public MemberException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public MemberException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

}
