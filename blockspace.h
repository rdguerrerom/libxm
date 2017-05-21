/*
 * Copyright (c) 2017 Ilya Kaliman
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#ifndef XM_BLOCKSPACE_H_INCLUDED
#define XM_BLOCKSPACE_H_INCLUDED

#include "dim.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Multidimensional block-space. */
typedef struct xm_block_space xm_block_space_t;

/* Create a block-space with specific absolute dimensions. */
xm_block_space_t *xm_block_space_create(xm_dim_t dims);

/* Create a deep copy of a block-space. */
xm_block_space_t *xm_block_space_clone(const xm_block_space_t *bs);

/* Return number of dimensions a block-space has. */
size_t xm_block_space_get_ndims(const xm_block_space_t *bs);

/* Return absolute dimensions of a block-space. */
xm_dim_t xm_block_space_get_abs_dims(const xm_block_space_t *bs);

/* Return block-space dimensions in number of blocks. */
xm_dim_t xm_block_space_get_nblocks(const xm_block_space_t *bs);

/* Split block-space along a dimension at point x. */
void xm_block_space_split(xm_block_space_t *bs, size_t dim, size_t x);

/* Return dimensions of a block with specific index. */
xm_dim_t xm_block_space_get_block_dims(const xm_block_space_t *bs,
    xm_dim_t blkidx);

/* Return size in number of elements of the largest block in block-space. */
size_t xm_block_space_get_largest_block_size(const xm_block_space_t *bs);

/* Return non-zero if the block-spaces have same block structures. */
int xm_block_space_eq(const xm_block_space_t *bsa, const xm_block_space_t *bsb);

/* Return non-zero if specific block-space dimensions have same block
 * structures. */
int xm_block_space_eq1(const xm_block_space_t *bsa, size_t dima,
    const xm_block_space_t *bsb, size_t dimb);

/* Release resources used by a block-space. */
void xm_block_space_free(xm_block_space_t *bs);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* XM_BLOCKSPACE_H_INCLUDED */