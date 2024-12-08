# beep-port
### _Mihai Cristian Tănase_ (ARKON)

Speak something when connections to the chosen port change.

Tested on macos.

## How to run

1. Without quicklisp
```sh
sbcl \
  --eval '(asdf:load-asd "beep-port.asd")' \
  --eval "(asdf:load-system :beep-port)" \
  --eval "(beep-port:run)"
```

2. With quicklisp
```sh
sbcl \
  --eval '(ql:quickload "beep-port")' \
  --eval "(beep-port:run)"
```

## Customize port

Change

    beep-port:*port*

For example, add
```sh
  --eval "(setf beep-port:*port* 8080)"
```
before 
```sh
  --eval "(beep-port:run)"
```

## License

MIT License
