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


## entrypoint.rs , programs and accounts

### Packages and crates

 A crate is a binary or library. The crate root is a source file that the Rust compiler starts from and makes up the root module of your crate

. A package is one or more crates that provide a set of functionality. A package contains a Cargo.toml file that describes how to build those crates.

Adding use and a path in a scope is similar to creating a symbolic link in the filesystem. By adding use crate::front_of_house::hosting in the crate root, hosting is now a valid name in that scope, just as though the hosting module had been defined in the crate root. Paths brought into scope with use also check privacy, like any other paths.

 Entrypoints are the only way to call a program; all calls go through the function declared as the entrypoint.

When called, a program is passed to its BPF Loader (opens new window)which processes the call. Different BPF loaders may require different entrypoints.

program_id is simply the program id of the currently executing program. Why you'd want access to it inside the program will become apparent later. intruction_data is data passed to the program by the caller, it could be anything. Finally, to understand what accounts are, we have to dive deeper into the solana programming model (opens new window).

accounts If you want to store state, use accounts (opens new window). Programs themselves are stored in accounts which are marked executable. Each account can hold data and SOL (opens new window). Each account also has an owner and only the owner may debit the account and adjust its data

### programs owning programs

Now you might be thinking "does that mean that my own SOL account is actually not owned by myself?". And you'd be right! But fear not, your funds are safu (opens new window). The way it works is that even basic SOL transactions are handled by a program on Solana: the system program. (As a matter of fact, even programs are owned by programs. Remember, they are stored in accounts and these executable accounts are owned by the BPF Loader. The only programs not owned by the BPF loader are - of course - the BPF loader itself and the System Program. 

This allows the runtime to parallelise transactions. If the runtime knows all the accounts that will be written to and read by everyone at all times it can run those transactions in parallel that do not touch the same accounts or touch the same accounts but only read and don't write. If a transaction violates this constraint and reads or writes to an account of which the runtime has not been notified, the transaction will fail.

The flow of a program using this structure looks like this:

Someone calls the entrypoint
The entrypoint forwards the arguments to the processor
The processor asks instruction.rs to decode the instruction_data argument from the entrypoint function.
Using the decoded data, the processor will now decide which processing function to use to process the request.
The processor may use state.rs to encode state into or decode the state of an account which has been passed into the entrypoint.

![](https://paulx.dev/assets/img/escrow-sketch-1.6df070a8.png)

Remember we have two parties Alice and Bob which means there are two system_program accounts. Because Alice and Bob want to transfer tokens, we'll make use of - you guessed it! - the token program. In the token program, to hold a token, you need a token account. Both Alice and Bob need an account for each token. So we get 4 more accounts. I'll call our tokens X and token Y, Alice gets an X and a Y account and so does Bob. (Our own tokens are X and Y but this escrow will work for any tokens on solana, like USDC (opens new window)and SRM (opens new window)). Since escrow creation and the trade won't happen inside a single transaction, it's probably a good idea to have another account to save some escrow data (it will e.g. store how much of token Y Alice wants in exchange for her token X, but we'll get to that later!). Note that this account is created for each exchange.

It would be much easier for Alice if she just had one private key for all her token accounts and this is exactly how the token program does it! It assigns each token account an owner. Note that this token account owner attribute is not the same as the account owner. The account owner is an internal Solana attribute that will always be a program. The new token owner attribute is something the token program declares in user space (i.e. in the program they are building). It's encoded inside a token account's data, in addition to other properties (opens new window)such as the balance of tokens the account holds.I will call the token owner "authority" and the solana internal owner "owner" in the rest of this post to avoid confusion. The existence of the authority also means that once a token account has been set up, its private key is useless, only its authority matters. And the authority is going to be some other address, in our case Alice's and Bob's main account addresses respectively. When making a token transfer they simply have to sign the tx (tx=transaction) with the private key of their main account.



