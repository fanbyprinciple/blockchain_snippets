### Environment Setup
1. Install Rust from https://rustup.rs/
2. Install Solana from https://docs.solana.com/cli/install-solana-cli-tools#use-solanas-install-tool

### Build and test for program compiled natively
```
$ cargo build
$ cargo test
```

### Build and test the program compiled for BPF
```
$ cargo build-bpf
$ cargo test-bpf
```

# Building an escrow project

https://paulx.dev/blog/2021/01/14/programming-on-solana-an-introduction/

### flow of the program

The flow of a program using this structure looks like this:

Someone calls the entrypoint
The entrypoint forwards the arguments to the processor
The processor asks instruction.rs to decode the instruction_data argument from the entrypoint function.
Using the decoded data, the processor will now decide which processing function to use to process the request.
The processor may use state.rs to encode state into or decode the state of an account which has been passed into the entrypoint.



