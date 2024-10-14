# WebVM xv6: Our Wild Ride Through Browser-Based OS Emulation

Hey there! Welcome to our CheerpX hackathon project. Let us tell you about our crazy attempt to run an entire operating system (well, a mini one) in your web browser. 

## What Were We Thinking?

The hackathon theme was "Crafting the Impossible," and we took that a little too seriously! We thought, "Hey, wouldn't it be cool to run xv6 (a teaching OS from one of our classes this semester) inside WebVM?" Spoiler alert: It was as hard as it sounds, but what a journey it was!

## Our Rollercoaster Ride

### First Stop: RISC-V Town
We started off ambitious. Like, really ambitious. We tried to run a 64-bit RISC-V version of xv6 on a 32-bit x86 emulated environment. In a browser. Yeah, we know.

- We crafted a custom Dockerfile with everything we thought we needed.
- Wrote a build script to automate creating ext2 disk images for us.
- Tried to bend WebVM to our will.
- Learned more about cross-architecture emulation than we ever thought we needed to know.

### Pivot City: x86 Valley
When RISC-V didn't pan out, did we give up? Nah! We switched gears to the (older) 32-bit x86 version of xv6. New plan, but same crazy energy.

- Whipped up a new Dockerfile faster than you can say "virtualization."
- Battled with building and testing x86 containers on an M1 Mac (fun times!).
- Tried to sweet-talk WebVM into playing nice with our xv6 files.

## The Plot Twists (aka Challenges)

### QEMU

A crucial part of our project involved working with QEMU, the machine emulator. Here's an overview of our experience:

1. **Installation**: We successfully installed QEMU in our Docker container as part of our setup.

2. **Consistent Issues**: Across all versions of QEMU we tried (for both RISC-V and x86), we encountered the same fundamental challenges.

3. **Missing Libraries**: The primary issue was missing libraries, particularly `libvirglrenderer.so.0`. This problem persisted regardless of the QEMU version or target architecture.

4. **WebVM Compatibility**: Even after addressing container-level issues, integrating QEMU with WebVM presented significant challenges. These difficulties were consistent across our attempts.

### Other Challenges

1. **Architecture Mismatch Mayhem**: Trying to run 64-bit stuff in a 32-bit world. I don't even know why we tried this.

2. **The Emulation Layer Cake**: We were dealing with multiple layers of virtualization and emulation:
	- Layer 1: WebVM emulating a 32-bit x86 environment in the browser
	- Layer 2: Our Docker container running on the emulated WebVM environment
	- Layer 3: QEMU attempting to emulate either RISC-V or x86 within the container
	- Layer 4: The xv6 operating system running on the QEMU-emulated hardware

	Each layer added complexity and potential performance overhead, creating a challenging environment for running an operating system.

## What We Learned (Besides Humility)

1. Emulation layers are like onions. They have layers, and sometimes they make you cry.
3. Cross-platform development is not for the faint of heart.
4. WebVM is cool.
5. Dockerfiles can be an art form. A confusing, complex art form.

In all honesty and seriousness, this was a deep dive into unchartered waters for us, we had:
- No experience with Dockerfiles
- Limited understanding of WebAssembly
- Basic knowledge of operating systems from our xv6 class

Through this challenge, we gained:
- Practical skills in Docker, containers and cross-architecture builds
- Deeper insights into WebAssembly and browser capabilities
- A newfound appreciation for the complexities of systems programming and a curiosity for learning more

## The Grand Finale

Did we get xv6 running in WebVM? Well, no. But did we learn a ton, pushed some boundaries, and had a blast doing it? Absolutely!

We may not have crafted the impossible, but we sure gave it our best shot. This project opened our eyes to the wild world of WebAssembly, and we're excited to see what comes next.

If you want to spin up the try our attempt, We've uploaded a pre-built image.

1. Clone the Repository: `git clone https://github.com/khanhadi/webvm.git`

2. Download the Image:
- Visit our GitHub releases page: https://github.com/khanhadi/webvm/releases/tag/v0.0.1
- Download the ext2 file provided in the release.

3. Move the downloaded ext2 file into the project directory you just cloned.

4. Serve!
