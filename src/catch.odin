package failz

import "core:fmt"
import "core:os"
import "core:strings"
import "libs:ansi"

catch :: proc(err: Error, msg: string = "", should_exit := true, location := #caller_location) {
	sb := strings.builder_make()
	fmt.sbprintfln(
		&sb,
		"%s %s: %s at %d:%d",
		ERROR,
		ansi.bold(location.file_path),
		purple(location.procedure),
		location.line,
		location.column,
	)

	if len(msg) != 0 {fmt.sbprintln(&sb, MESSAGE, msg)}

	#partial switch e in err {
	case AllocError:
		fmt.sbprint(&sb, MESSAGE, e)
		fmt.eprintln(strings.to_string(sb))
	case SystemError:
		fmt.sbprint(&sb, MESSAGE, purple(fmt.tprintf("[%v]", e.kind)), e.msg)
		fmt.eprintln(strings.to_string(sb))
	case Errno:
		if e == .ERROR_NONE {return}
		fmt.sbprint(&sb, MESSAGE, os.get_last_error_string())
		fmt.eprintln(strings.to_string(sb))
	case bool:
		if !e {return}
		fmt.eprintln(strings.to_string(sb))
	}

	if err != nil && should_exit {os.exit(1)}
}
