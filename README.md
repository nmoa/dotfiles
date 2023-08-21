# nmoa's dotfiles
nmoa's dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

# How to use
1. Install chezmoi:
    ```bash
    sh -c "$(curl -fsLS get.chezmoi.io)"
    ```
    details: <https://www.chezmoi.io/install/>

1. Initialize chezmoi.
   
    ```bash
    chezmoi init nmoa
    ```

1. Add template data to `~/.config/chezmoi/chezmoi.toml` like this:

     ```toml
     [data]
       name = "John Doe"
       email = "John.Doe@example.com"
     ```

1. Apply dotfiles.

     ```bash
     chezmoi apply
     ```
