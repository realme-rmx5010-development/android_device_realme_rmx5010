#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE = "rmx5010"
VENDOR = "realme"

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

module = ExtractUtilsModule(
    DEVICE,
    VENDOR,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
