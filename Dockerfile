FROM python:3.12.11-bookworm AS base

# Update OS
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        vim-tiny \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

FROM base AS builder
COPY --from=ghcr.io/astral-sh/uv:0.8.9 /uv /bin/uv
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

WORKDIR /calculate_pi

COPY uv.lock pyproject.toml /calculate_pi/
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-install-project --no-dev
COPY calculate_pi /calculate_pi/calculate_pi/
COPY README.md LICENSE.txt /calculate_pi/
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

FROM base AS final
LABEL maintainer="Erik Ferlanti <eferlanti@tacc.utexas.edu>"

# Configure Python/Pip
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1

WORKDIR /calculate_pi

COPY --from=builder /calculate_pi /calculate_pi
ENV PATH="/calculate_pi/.venv/bin:$PATH"

CMD [ "calculate-pi", "--help" ]
