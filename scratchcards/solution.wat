(module
	(memory (import "js" "mem") 1)
	(global $end_of_input (import "js" "endOfInput") i32)

	(import "console" "log" (func $log (param i32) (result i32)))
	(import "js" "parseNum" (func $parse_num (param i32) (result i32)))

	(func (export "solve") (result i32)
		(local $solution_accumulator i32)
		(local $line_position i32)
		(local $solve_line_output i64)
	
		(loop $loop
			;; Solve the line
			local.get $line_position
			global.get $end_of_input
			call $solve_line

			;; Process the return value
			local.tee $solve_line_output

			i32.wrap_i64
			local.get $solution_accumulator
			i32.add
			call $log
			local.set $solution_accumulator

			local.get $solve_line_output
			i64.const 32
			i64.shr_u
			i32.wrap_i64
			call $log
			local.tee $line_position

			;; Loop if we haven't done everything yet
			global.get $end_of_input
			i32.const 1
			i32.sub
			i32.ne
			br_if $loop
		)

		local.get $solution_accumulator
	)

	;; Return is 4 bytes for the position after the newline and 4 bytes for the result
	(func $solve_line (param $start_of_line i32) (param $start_of_scratch i32) (result i64)
		;; I'm using the scratch space to store the winning numbers
		(local $winning_number_pos i32)
		(local $winning_number_count i32)

		i32.const 0
		local.set $winning_number_pos
	
		;; Skip to the first colon
		(loop $skip_to_colon
			;; Compare the character
			local.get $start_of_line
			i32.load
			i32.const 0xff
			i32.and
			i32.const 58 ;; :
			i32.ne

			;; Go to next char
			local.get $start_of_line
			i32.const 1
			i32.add
			local.set $start_of_line

			br_if $skip_to_colon
		)

		;; Skip the space
		local.get $start_of_line
		i32.const 1
		i32.add
		local.set $start_of_line

		;; Load the winning numbers
		(loop $load_nums_loop
			;; Find the address to write the number
			local.get $start_of_scratch
			local.get $winning_number_pos
			i32.add
		
			;; Parse the winning number
			local.get $start_of_line
			call $parse_num

			;; Store it
			i32.store

			;; Set the memory address for the next winning number
			local.get $winning_number_pos
			i32.const 4
			i32.add
			local.set $winning_number_pos

			;; Skip to the next number
			local.get $start_of_line
			i32.const 3
			i32.add
			local.set $start_of_line

			;; Compare the character
			local.get $start_of_line
			i32.load
			i32.const 0xff
			i32.and
			i32.const 124 ;; Pipe
			i32.ne

			br_if $load_nums_loop
		)

		;; Skip the pipe (land on the space so as we keep adding three we'll land on the newline instead of skipping over it to the next card)
		local.get $start_of_line
		i32.const 1
		i32.add
		local.set $start_of_line

		;; Check the card numbers
		(loop $check_nums_loop
			;; Parse the number
			local.get $start_of_line
			call $parse_num

			;; Check the number and maybe increment $winning_number_count
			local.get $start_of_scratch
			local.get $start_of_scratch
			local.get $winning_number_pos
			i32.add
			call $check_num
			local.get $winning_number_count
			i32.add
			local.set $winning_number_count

			;; Skip to the next number
			local.get $start_of_line
			i32.const 3
			i32.add
			local.set $start_of_line

			;; Compare the character
			local.get $start_of_line
			i32.load
			i32.const 0xff
			i32.and
			i32.const 10 ;; \n
			i32.ne

			br_if $check_nums_loop
		)

		;; Return the result + funny exponent thing
		i32.const 1
		local.get $winning_number_count
		i32.const 1
		i32.sub
		i32.shl
		i64.extend_i32_u

		local.get $start_of_line
		i64.extend_i32_u
		i64.const 32
		i64.shl

		i64.or
	)

	(func $check_num (param $num i32) (param $winning_numbers_buf_addr i32) (param $buf_end_addr i32) (result i32)
		(loop $check_loop
			;; Load the number in memory and compare it with the number given
			local.get $winning_numbers_buf_addr
			i32.load
			local.get $num
			i32.ne

			(if (then
				;; Go to the next number
				local.get $winning_numbers_buf_addr
				i32.const 4
				i32.add
				local.tee $winning_numbers_buf_addr

				;; Continue if I haven't hit the end of the buffer yet
				local.get $buf_end_addr
				i32.ne
				br_if $check_loop
			) (else
				;; Return if they are equal
				i32.const 1
				return
			))
		)
	
		i32.const 0
	)
)
