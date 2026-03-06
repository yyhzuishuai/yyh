<template>
	<div id="tags-view-container" class="tags-view-container">
		<scroll-pane ref="scrollPane" class="tags-view-wrapper">
			<router-link v-for="tag in visitedViews" ref="tag" :key="tag.path" :class="isActive(tag)?'active':''"
				:to="{ path: tag.path, query: tag.query, fullPath: tag.fullPath }" tag="span" class="tags-view-item"
				@click.middle.native="closeSelectedTag(tag)" @contextmenu.prevent.native="openMenu(tag,$event)">
                {{ tag.meta.title||tag.name }}
				<el-icon class="el-icon-close" v-if="!tag.meta.affix" @click.prevent.stop="closeSelectedTag(tag)">
					<Close />
				</el-icon>
			</router-link>
		</scroll-pane>
		<ul v-show="visible" :style="{left:left+'px',top:top+'px'}" class="contextmenu">
			<li v-if="!(selectedTag.meta&&selectedTag.meta.affix)" @click="closeSelectedTag(selectedTag)">Close</li>
			<li @click="closeAllTags(selectedTag)">Close All</li>
		</ul>
	</div>
</template>

<script>
	import ScrollPane from './indexScrollPane'
	import {
		useStore
	} from 'vuex'

	export default {
		components: {
			ScrollPane
		},
		data() {
			return {
				visible: false,
				top: 0,
				left: 0,
				selectedTag: {},
				affixTags: []
			}
		},
		computed: {
			visitedViews() {
				return this.$store.state.visitedViews
			},
			routes() {
				return this.$store.state.routes
			}
		},
		watch: {
			$route() {
				this.addTags()
				// this.moveToCurrentTag()
			},
			visible(value) {
				if (value) {
					document.body.addEventListener('click', this.closeMenu)
				} else {
					document.body.removeEventListener('click', this.closeMenu)
				}
			}
		},
		mounted() {
			this.$store.dispatch('updateSideMenus')
			this.initTags()
			this.addTags()
		},
		methods: {
			isActive(route) {
				return route.path === this.$route.path
			},
			filterAffixTags(routes, basePath = '/') {
				let tags = []
				routes.forEach(route => {
					if (route.meta && route.meta.affix) {
						tags.push({
							fullPath: '/',
							path: '/',
							name: route.name,
							meta: {
								...route.meta
							}
						})
					}
					if (route.children) {
						const tempTags = this.filterAffixTags(route.children, route.path)
						if (tempTags.length >= 1) {
							tags = [...tags, ...tempTags]
						}
					}
				})
				return tags
			},
			initTags() {
				const affixTags = this.affixTags = this.filterAffixTags(this.routes)
				for (const tag of affixTags) {
					// Must have tag name
					if (tag.name) {
						this.$store.dispatch('addVisitedView', tag)
					}
				}
			},
			addTags() {
				const {
					name
				} = this.$route
				if (name) {

					this.$store.dispatch('addView', this.$route)
				}
				return false
			},
			// moveToCurrentTag() {
			// 	const tags = this.$refs.tag
			// 	this.$nextTick(() => {
			// 		for (const tag of tags) {
			// 			if (tag.to.path === this.$route.path) {
			// 				this.$refs.scrollPane.moveToTarget(tag)
			// 				// when query is different then update
			// 				if (tag.to.fullPath !== this.$route.fullPath) {
			// 					this.$store.dispatch('updateVisitedView', this.$route)
			// 				}
			// 				break
			// 			}
			// 		}
			// 	})
			// },
			closeSelectedTag(view) {
				this.$store.dispatch('delView', view).then(({
					visitedViews
				}) => {
					if (this.isActive(view)) {
						this.toLastView(visitedViews, view)
					}
				})
			},
			closeAllTags(view) {

				this.$store.dispatch('delAllViews').then(({
					visitedViews
				}) => {
					if (this.affixTags.some(tag => tag.path === view.path)) {
						return
					}
					this.toLastView(visitedViews, view)
				})
			},
			toLastView(visitedViews, view) {
				const latestView = visitedViews.slice(-1)[0]
				if(latestView.name=='首页'){
					this.$router.push('/')
					return false
				}
				if (latestView) {
					this.$router.push(latestView)
				} else {
					// now the default is to redirect to the home page if there is no tags-view,
					// you can adjust it according to your needs.
					if (view.name === '首页') {
						// to reload home page
						this.$router.replace({
							path: '/redirect' + view.fullPath
						})
					} else {
						this.$router.push('/')
					}
				}
			},
			openMenu(tag, e) {
				const menuMinWidth = 105
				const offsetLeft = this.$el.getBoundingClientRect().left // container margin left
				const offsetWidth = this.$el.offsetWidth // container width
				const maxLeft = offsetWidth - menuMinWidth // left boundary
				const left = e.clientX - offsetLeft + 15 // 15: margin right

				if (left > maxLeft) {
					this.left = maxLeft
				} else {
					this.left = left
				}

				this.top = 36
				this.visible = true
				this.selectedTag = tag
			},
			closeMenu() {
				this.visible = false
			}
		}
	}
</script>

<style lang="scss" scoped>
	.tags-view-container {
		.tags-view-wrapper {
			.tags-view-item {
				&:first-of-type {
					margin-left: 15px;
				}

				&:last-of-type {
					margin-right: 15px;
				}

				&.active {
					&::before {
						content: '';
						background: #fff;
						display: inline-block;
						width: 8px;
						height: 8px;
						border-radius: 50%;
						position: relative;
						margin-right: 2px;
					}
				}
			}
		}
	}
</style>

<style lang="scss">
	a {
		text-decoration-line: none;
	}
	//reset element css of el-icon-close
	.tags-view-wrapper {
		display: flex;
		justify-content: flex-start;

		.tags-view-item {
			.el-icon-close {
				width: 16px;
				height: 16px;
				vertical-align: 2px;
				border-radius: 50%;
				text-align: center;
				transition: all .3s cubic-bezier(.645, .045, .355, 1);
				transform-origin: 100% 50%;
				margin-right: 0;
				margin-left: 6px;

				&:before {
					transform: scale(.6);
					display: inline-block;
					vertical-align: -3px;
				}

				&:hover {
					background-color: transparent;
					color: #FF4444;
				}
			}
		}
	}
</style>
<style>
/* Tab 容器 */
#tags-view-container {
    background-color: #FFFFFF;
    border-bottom: 2px solid #FFE4EC;
    padding: 6px 12px 0;
    margin: 0;
    border-radius: 0;
}

#tags-view-container .el-scrollbar__view {
    display: flex;
    align-items: center;
    padding: 4px 0;
}

/* 单个 Tab */
#tags-view-container .tags-view-item {
    background-color: #FFFFFF;
    color: #888888;
    border: 1px solid #FFD6C0;
    border-bottom: none;
    border-radius: 8px 8px 0 0;
    margin-right: 4px;
    padding: 6px 14px;
    display: inline-flex;
    align-items: center;
    box-sizing: border-box;
    white-space: nowrap;
    flex-shrink: 0;
    gap: 0;
    font-size: 14px;
    line-height: 22px;
    cursor: pointer;
    transition: all 0.2s ease;
    height: auto;
    min-height: 42px;
}

/* Tab Hover */
#tags-view-container .tags-view-item:hover {
    background-color: #FFF0E8;
    color: #CC4400;
}

/* 激活的 Tab */
#tags-view-container .active.tags-view-item {
    background-color: #FF8C69;
    color: #FFFFFF;
    border-color: #FF8C69;
    font-weight: 600;
}

/* 移除激活 Tab 的小圆点 */
#tags-view-container .tags-view-wrapper .tags-view-item.active:before {
    content: none;
}

/* 关闭按钮 */
.tags-view-item .el-icon-close {
    opacity: 0.6;
    font-size: 12px;
    margin-left: 6px;
    transition: all 0.2s ease;
    border-radius: 50%;
    padding: 2px;
    flex: 0 0 auto;
}

.tags-view-item .el-icon-close:hover {
    opacity: 1;
    color: #FF4444 !important;
}

/* 激活 Tab 上的关闭按钮 */
.active.tags-view-item .el-icon-close {
    color: #FFFFFF;
}

#tags-view-container .el-scrollbar__wrap {
    height: auto!important;
}
</style>
