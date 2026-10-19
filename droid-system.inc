%define __find_provides %{nil}
%define __find_requires %{nil}
%define __strip /bin/true
%define __provides_exclude_from ^/system/.*$
%define __requires_exclude ^.*$
%global debug_package %{nil}

%if 0%{!?rpm_device:1}
%define rpm_device %{device}
%endif
%if 0%{!?dsd_path:1}
%define dsd_path .
%endif
%if 0%{!?variant:1}
%define variant %{nil}
%endif

Name:       droid-system%{variant}-%{rpm_device}
Provides:   droid-system%{variant}
Summary:    System%{variant} package for Droid HAL adaptations
%if 0%{?separate_odm_rpm:1}
Requires(post): droid-system%{variant}-%{rpm_device}-odm
%endif
%if 0%{?separate_product_rpm:1}
Requires(post): droid-system%{variant}-%{rpm_device}-product
%endif
%if 0%{?separate_system_ext_rpm:1}
Requires(post): droid-system%{variant}-%{rpm_device}-system_ext
%endif
%if 0%{?separate_vendor_rpm:1}
Requires(post): droid-system%{variant}-%{rpm_device}-vendor
%endif
Version:    1
Release:    1
%if 0%{?system_license:1}
License:    %{system_license}
%else
License:    Proprietary
%endif
Source0:    %{name}-%{version}.tar.bz2
Source1:    droid-system%{variant}-rpmlintrc
URL:        https://github.com/mer-hybris/droid-system-device
%description
%{summary}.

%if 0%{?separate_odm_rpm:1}
%package    odm
Provides:   droid-system%{variant}-odm
Summary:    System%{variant}-odm package for Droid HAL adaptations

%description odm
%{summary}.
%endif

%if 0%{?separate_product_rpm:1}
%package    product
Provides:   droid-system%{variant}-product
Summary:    System%{variant}-product package for Droid HAL adaptations

%description product
%{summary}.
%endif

%if 0%{?separate_system_ext_rpm:1}
%package    system_ext
Provides:   droid-system%{variant}-system_ext
Summary:    System%{variant}-system_ext package for Droid HAL adaptations

%description system_ext
%{summary}.
%endif

%if 0%{?separate_vendor_rpm:1}
%package    vendor
Provides:   droid-system%{variant}-vendor
Summary:    System%{variant}-vendor package for Droid HAL adaptations

%description vendor
%{summary}.
%endif

%prep
%if 0%{?_obs_build_project:1}
# For OBS builds we need to have tarball extracted after tar_git packaging it
%setup -q -n %{name}-%{version}
%endif

# This section is empty by purpose
%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}

# Retain permissions:
rm -rf tmp/
mkdir -p tmp/
touch tmp/droid-system.files

# Prefer files from sparse/ in the HA specific
# area over sparse/ in the dsd area
copy_files_from() {
  source_dir=$1
  if [ -d $source_dir ]; then
    (cd $source_dir; find . \( -type f -o -type l \) -print ) | sed 's/^.//' >> tmp/droid-system.files
    cp -R $source_dir/* $RPM_BUILD_ROOT/
  fi
}

delete_files() {
  files=$1
  deletelist=$2
  dorm=$3
  if [ -e $deletelist ]; then
    egrep -v '^#' $deletelist | (
      while read file; do
	[ "x$dorm" = "x1" ] && rm $RPM_BUILD_ROOT/$file
	grep -vE "$file" $files > tmp/$$.files
	mv tmp/$$.files $files
      done)
  fi
}

# Copy from sparse; erase any we don't want
copy_files_from %{dsd_path}/sparse
delete_files tmp/droid-system.files delete_file.list 1

%files -f tmp/droid-system.files
%if 0%{?separate_odm_rpm:1}
%exclude /odm
%endif
%if 0%{?separate_product_rpm:1}
%exclude /product
%endif
%if 0%{?separate_system_ext_rpm:1}
%exclude /system_ext
%endif
%if 0%{?separate_vendor_rpm:1}
%exclude /vendor
%endif

%if 0%{?separate_odm_rpm:1}
%files odm
/odm
%endif

%if 0%{?separate_product_rpm:1}
%files product
/product
%endif

%if 0%{?separate_system_ext_rpm:1}
%files system_ext
/system_ext
%endif

%if 0%{?separate_vendor_rpm:1}
%files vendor
/vendor
%endif
