#!/usr/bin/env python

import base64
import hashlib


def main():
    host_keys = {
        'rsa': '/etc/ssh/ssh_host_rsa_key.pub',
        'dsa': '/etc/ssh/ssh_host_dsa_key.pub',
        'ecdsa': '/etc/ssh/ssh_host_ecdsa_key.pub',
    }

    ssh_fingerprints = {}
    for key_type, filename in host_keys.items():
        try:
            ssh_fingerprints[key_type] = _get_ssh_fingerprint(filename)
        except IOError:
            pass

    if ssh_fingerprints:
        return {
            'ssh_fingerprints': ssh_fingerprints
        }
    else:
        return None


def _get_ssh_fingerprint(filename):
    with open(filename, 'r') as fh:
        key = base64.b64decode(fh.read().strip().split()[1].encode('ascii'))
    fp_plain = hashlib.md5(key).hexdigest()
    return ':'.join(a+b for a, b in zip(fp_plain[::2], fp_plain[1::2]))
