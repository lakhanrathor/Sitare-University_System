/**
 * Which swap states are still live.
 *
 * The states themselves are the `SwapStatus` enum in schema.prisma and the
 * database enforces them; a second list here was a copy nothing read.
 *
 * This is the set a request can still be acted on from: the counterparty
 * may decline and the requester may withdraw right up until an administrator
 * decides. Keeping it beside the states rather than deriving it means the two
 * stages — the other lecturer agreeing, then the admin approving — cannot
 * drift apart.
 */
export const SWAP_OPEN = ['pending', 'accepted'];
