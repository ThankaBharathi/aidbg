"""Main CLI entry point for aidbg."""

import typer
from rich.console import Console

app = typer.Typer(
    name="aidbg",
    help="AI-powered CLI debugger that understands and fixes your code errors.",
    add_completion=False,
)
console = Console()


@app.callback()
def callback() -> None:
    """
    Aidbg - Your AI debugging assistant.
    """
    pass


@app.command()
def version() -> None:
    """Show version information."""
    from src import __version__

    console.print(f"[bold blue]aidbg[/bold blue] version {__version__}")


if __name__ == "__main__":
    app()
