---
sort: 46
---

# node

This is in accordance with the GNU software,

```bash
wget -qO- https://github.com/nodejs/node/archive/refs/tags/v18.20.5.tar.gz | \
tar xvfz -
cd node-18.20.5
./configure --prefix=$CEUADMIN/node/18.20.5
make
```

The location can be made aware in `${HOME}/.npmrc` in which

```
prefix=${CEUADMIN}/node/18.20.5
```

where one can proceed with `npm install -g @marp-team/marp-cli`. Alternatively, one can do the following,

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
rm -rf ~/.npm
nvm install 18
nvm use 18
source ~/.bashrc
nvm use --delete-prefix v18.20.6
node -v
npm -v
npm install -g @marp-team/marp-cli puppeteer-core puppeteer
npm list -g @marp-team/marp-cli
npm cache clean --force
```

and one can see the definition `export NVM_DIR="$HOME/.nvm"`. The latest version is made available with,

```bash
nvm install --lts
nvm use --lts
marp gaaw2.md
```

Example use,

```js
const puppeteer = require("/home/jhz22/.nvm/versions/node/v22.13.1/lib/node_modules/puppeteer");
(async () => {
  try {
    const browser = await puppeteer.launch({
      executablePath: process.env.PUPPETEER_EXECUTABLE_PATH,
      headless: "new",
      args: ["--no-sandbox", "--user-data-dir=/tmp"],
    });
    const page = await browser.newPage();
    await page.goto("https://www.google.com");
    await page.screenshot({ path: "example.png" });
    console.log("Screenshot saved to example.png");
    await browser.close();
  } catch (error) {
    console.error("Error launching Puppeteer:", error);
  }
})();
```

Analogy can be made with `npm`,

```bash
cd ~
curl -L https://www.npmjs.com/install.sh | sh
```

The NODE_PATH variable is output from running `readlink -f ../lib/node_modules` at the `bin/` directory.

The useful `codedown` module can be made available as follows,

```bash
module load ceuadmin/node
npm install -g codedown
```

We see that

```
added 8 packages in 5s
npm notice
npm notice New major version of npm available! 10.8.2 -> 11.1.0
npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.1.0
npm notice To update run: npm install -g npm@11.1.0
npm notice
```

As suggesteed, we issue `npm install -g npm@11.1.0` to see

```
removed 8 packages, and changed 100 packages in 19s

24 packages are looking for funding
  run `npm fund` for details
```

We can extract Python code as `cat DeepSeek.md | codedown python`.
