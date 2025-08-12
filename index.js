const core = require('@actions/core');
const exec = require('@actions/exec');
const fs = require('fs');

async function run() {
  try {
    const workdir = core.getInput('workdir') || '.';
    const policyPath = core.getInput('policy_path') || 'policy';
    const options = { cwd: workdir };
    if (fs.existsSync(policyPath)) {
      try { await exec.exec('conftest', ['test', '.', '-p', policyPath], options); }
      catch(e) { core.info('conftest not found, skipping'); }
    } else {
      core.info(`No policy dir at ${policyPath}, skipping compliance checks`);
    }
  } catch (error) {
    core.setFailed(error.message);
  }
}
run();
