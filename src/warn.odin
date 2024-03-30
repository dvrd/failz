package failz

import "core:fmt"
import "core:os"

warn :: proc(err: Error = true, msg := "") {
	#partial switch e in err {
	case AllocError:
		fmt.eprintln(WARNING, msg, e)
	case SystemError:
		fmt.eprintln(WARNING, msg, e.msg)
	case Errno:
		if e != .ERROR_NONE {
			fmt.eprintfln(
				"%s [%v]",
				WARNING,
				Errno(os.get_last_error()),
				msg,
				os.get_last_error_string(),
			)}
	case bool:
		if e {fmt.eprintln(WARNING, msg)}
	}
}
